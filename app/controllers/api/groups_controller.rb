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
    group = Group.find(params[:group_id])

    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(group.teachers, each_serializer: TeacherWithGroupTeachersPrincipalSerializer)
    )

    render json: response, status: :ok
  end

  def students
    group = Group.find(group_students_params[:group_id])
    students = group.students

    response = Panko::Response.new(
      students: Panko::ArraySerializer.new(students, each_serializer: StudentSerializer)
    )

    render json: response, status: :ok
  end

  private
  def group_params
    params.require(:group).permit(:group_id, :name, :year)
  end

  def group_students_params
    params.permit(:group_id)
  end
end
