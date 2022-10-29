class Api::TeachersController < Api::BaseController
  def index
    teachers = User.by_role_name("teacher")
    
    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeacherSerializer)
    )

    render json: response, status: :ok
  end
end

