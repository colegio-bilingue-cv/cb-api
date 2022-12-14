class Api::AnswersController < Api::BaseController
  before_action :validate_question, only: [:create]

  def create
    student = Student.find(params[:student_id])

    answer = student.answers.create!(answer_params)

    response = Panko::Response.create do |r|
      { answer: r.serializer(answer, AnswerWithStudentQuestionSerializer) }
    end

    render json: response, status: :created
  end

  def update
    student = Student.find(params[:student_id])
    answer = student.answers.find(params[:id])

    answer.update!(answer_params)

    response = Panko::Response.create do |r|
      { answer: r.serializer(answer, AnswerWithStudentQuestionSerializer) }
    end

    render json: response, status: :ok
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :question_id)
  end

  def validate_question
    Question.find(answer_params[:question_id])
  end

end
