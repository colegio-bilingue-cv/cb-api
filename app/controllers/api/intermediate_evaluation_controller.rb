class Api::IntermediateEvaluationController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(intermediate_evaluation_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(intermediate_evaluation_params[:group_id])

    intermediate_evaluation = IntermediateEvaluation.create!(intermediate_evaluation_params)

    response = Panko::Response.create do |r|
      { intermediate_evaluation: r.serializer(intermediate_evaluation, IntermediateEvaluationSerializer) }
    end

    render json: response, status: :created
  end

  private

  def intermediate_evaluation_params
    params.require(:intermediate_evaluation).permit(:student_id, :group_id, :starting_month, :ending_month)
  end
end
