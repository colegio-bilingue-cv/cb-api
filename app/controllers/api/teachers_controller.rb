class Api::TeachersController < Api::BaseController
  def index
    teachers = User.with_role(:teacher)

    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeacherWithGroupTeachersPrincipalSerializer)
    )

    render json: response, status: :ok
  end
end
