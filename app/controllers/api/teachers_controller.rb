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

  def assign
    raise ActiveRecord::RecordNotFound.new('', User.to_s) unless User.exists?(params[:teacher][:user_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(params[:group_id])

    role_id = Role.find_by(name: :teacher).id

    user_group = UserGroup.create!(user_id: params[:teacher][:user_id], group_id: params[:group_id], role_id: role_id)

    response = Panko::Response.create do |r|
      { user_group: r.serializer(user_group, UserGroupSerializer) }
    end

    render json: response, status: :created
  end

  def dismiss
    raise ActiveRecord::RecordNotFound.new('', User.to_s) unless User.exists?(params[:teacher][:user_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(params[:group_id])
    raise ActiveRecord::RecordNotFound.new('', UserGroup.to_s) unless UserGroup.exists?(user_id: params[:teacher][:user_id], group_id: params[:group_id])

    UserGroup.where(user_id: params[:teacher][:user_id], group_id: params[:group_id]).delete_all

    render json: {}, status: :ok
  end


  private
  def user_group_params
    params.require(:user_group).permit(:user_id, :group_id)
  end
end
