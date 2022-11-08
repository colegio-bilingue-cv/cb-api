class Api::FinalEvaluationController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(final_evaluation_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(final_evaluation_params[:group_id])

    final_evaluation = FinalEvaluation.create!(final_evaluation_params)

    response = Panko::Response.create do |r|
      { final_evaluation: r.serializer(final_evaluation, FinalEvaluationSerializer) }
    end

    render json: response, status: :created
  end

  def update
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(final_evaluation_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(final_evaluation_params[:group_id])

    final_evaluation = FinalEvaluation.find(params[:id])
    final_evaluation.update!(final_evaluation_params)

    response = Panko::Response.create do |r|
      { final_evaluation: r.serializer(final_evaluation, FinalEvaluationSerializer) }
    end

    render json: response, status: :ok
  end

  def destroy
    student = Student.find(params[:student_id])
    student.final_evaluations.destroy(params[:id])

    head :no_content, status: :deleted
  end


  private

  def final_evaluation_params
    params.permit(:status, :group_id, :report_card, :student_id)
  end
end
