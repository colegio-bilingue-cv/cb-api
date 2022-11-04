class Api::TeachersController < Api::BaseController
  def index
    teachers = User.with_role(:teacher)

    if params.has_key?(:group_id)
      raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(params[:group_id])
      teachers = teachers.joins(:user_groups).where('"user_groups"."group_id" = ?', params[:group_id])
    end

    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeacherSerializer)
    )

    render json: response, status: :ok
  end

end
