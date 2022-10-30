class Api::IntermediateEvaluationController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(intermediate_evaluation_params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(params[:student_id])

    intermediate_evaluation = IntermediateEvaluation.create!(intermediate_evaluation_params) do |intermediate_evaluation|
      intermediate_evaluation.student_id = params[:student_id]
    end

    response = Panko::Response.create do |r|
      { intermediate_evaluation: r.serializer(intermediate_evaluation, IntermediateEvaluationSerializer) }
    end

    render json: response, status: :created
  end

  def update
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(intermediate_evaluation_params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(params[:student_id])

    intermediate_evaluation = IntermediateEvaluation.find(params[:id])
    intermediate_evaluation.update!(intermediate_evaluation_params)

    response = Panko::Response.create do |r|
      { intermediate_evaluation: r.serializer(intermediate_evaluation, IntermediateEvaluationSerializer) }
    end

    render json: response, status: :ok
  end

  private

  def intermediate_evaluation_params
    params.require(:intermediate_evaluation).permit(:group_id, :starting_month, :ending_month)
  end
end
