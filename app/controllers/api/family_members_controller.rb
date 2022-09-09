class Api::StudentController < BaseController
  def create
    student = Student.find(params[:student_id])
    family_member = student.family_member.create(family_member)
    render json: student, status: :created #201
  end

    private
    def family_member_params
      params.require(:family_member).permit(:ci)
    end
end
