class Api::IntermediateEvaluationsController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(intermediate_evaluation_params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(intermediate_evaluation_params[:student_id])

    intermediate_evaluation = IntermediateEvaluation.create!(intermediate_evaluation_params)

    response = Panko::Response.create do |r|
      { intermediate_evaluation: r.serializer(intermediate_evaluation, IntermediateEvaluationSerializer) }
    end

    render json: response, status: :created
  end

  def update
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(intermediate_evaluation_params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(intermediate_evaluation_params[:student_id])

    intermediate_evaluation = IntermediateEvaluation.find(params[:id])
    intermediate_evaluation.update!(intermediate_evaluation_params)

    response = Panko::Response.create do |r|
      { intermediate_evaluation: r.serializer(intermediate_evaluation, IntermediateEvaluationSerializer) }
    end

    render json: response, status: :ok
  end

  def destroy
    student = Student.find(params[:student_id])
    student.intermediate_evaluations.destroy(params[:id])

    head :no_content, status: :deleted
  end

  private

  def intermediate_evaluation_params
    params.permit(:group_id, :student_id, :starting_month, :ending_month, :report_card)
  end
end
