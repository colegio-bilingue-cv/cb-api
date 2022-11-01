class Api::TeachersController < Api::BaseController
  def index
    teachers = User.with_role(:teacher)

    if params.has_key?(:group_id)
      teachers = teachers.join(:groups).where(groups: { id: params[:group_id]})
    end

    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeacherSerializer)
    )

    render json: response, status: :ok
  end

  def assign
    p params
    raise ActiveRecord::RecordNotFound.new('', User.to_s) unless User.exists?(params[:teacher][:user_id])
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) unless Group.exists?(params[:group_id])
    #tirar error cuando ya exista una instancia entre g y u

    role_id = Role.find_by(name: 'teacher').id

    user_group = UserGroup.create!(user_id: params[:teacher][:user_id], group_id: params[:group_id], role_id: role_id)
    p "group ai d"
    p params[:group_id].to_i
    teachers = User.with_role(:teacher).join(:user_groups).where("user_groups.group_id" =>  params[:group_id])

    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeacherSerializer)
    )

    render json: response, status: :created
  end


  private
  def user_group_params
    params.require(:user_group).permit(:user_id, :group_id)
  end
end
