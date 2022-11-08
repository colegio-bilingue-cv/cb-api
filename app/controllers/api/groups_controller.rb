class Api::GroupsController < Api::BaseController
  def index
    groups = Group.all

    response = Panko::Response.new(
      groups: Panko::ArraySerializer.new(groups, each_serializer: GroupWithGradeTeachersPrincipalSerializer)
    )

    render json: response, status: :ok
  end

  def create
    grade = Grade.find(params[:grade_id])
    group = grade.groups.create!(group_params)

    response = Panko::Response.create do |r|
      { grade: { group: r.serializer(group, GroupSerializer) } }
    end

    render json: response, status: :created
  end

  def update
    grade = Grade.find(params[:grade_id])
    group = grade.groups.find(params[:id])

    group.update!(group_params)

    response = Panko::Response.create do |r|
      { grade: { group: r.serializer(group, GroupSerializer) } }
    end

    render json: response, status: :ok
  end

  def teachers
      teachers = User.with_role(:teacher)
      teachers = teachers.joins(:user_groups).where('"user_groups"."group_id" = ?', params[:group_id])

      response = Panko::Response.new(
        teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeacherSerializer)
      )

      render json: response, status: :ok
  end

  private
  def group_params
    params.require(:group).permit(:name, :year)
  end
end
