class Api::StudentController < BaseController
  def create
    student = Student.create(student_params)
    render json: student, status: :created #201
#setear status
  end

    private
    def student_params
      params.require(:student).permit(:ci, :surname, :second_surname, :first_name, :middle_name, :birthplace, :birthdate, :nacionality, :first_language, :address, :neighborhood, :medical_assurance, :emergency, :vaccine_name, :vaccine_expiry)
    end
end
