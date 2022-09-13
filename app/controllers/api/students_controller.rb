class Api::StudentsController < Api::BaseController
  def create
    student = Student.create!(student_params)

    render json: StudentSerializer.new.serialize_to_json(student), status: :created
  end

  private
  def student_params
    params.require(:student).permit(:ci, :surname,
      :name, :birthplace, :birthdate, :nacionality,
      :first_language, :address, :neighborhood, :medical_assurance,
      :emergency, :vaccine_name, :vaccine_expiration
    )
  end
end
