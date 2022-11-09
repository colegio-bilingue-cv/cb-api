class Api::SupportTeachersController < Api::BaseController
  def index
    support_teachers = User.with_role(:support_teacher)

    response = Panko::Response.new(
      support_teachers: Panko::ArraySerializer.new(support_teachers, each_serializer: SupportTeacherSerializer)
    )

    render json: response, status: :ok
  end
end
