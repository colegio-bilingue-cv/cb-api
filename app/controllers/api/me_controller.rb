class Api::MeController < Api::BaseController

  def show
    response = Panko::Response.create do |r|
      { me: r.serializer(current_user, UserWithFullInformationSerializer) }
    end

    render json: response, status: :ok
  end

  def update
    current_user.update!(me_params)

    response = Panko::Response.create do |r|
      { user: r.serializer(current_user, UserSerializer) }
    end

    render json: response, status: :ok
  end

  def password
    current_user.change_password!(password: me_password_params[:password], password_confirmation: me_password_params[:password_confirmation], current_password: me_password_params[:current_password])

    response = Panko::Response.create do |r|
      { user: r.serializer(current_user, UserSerializer) }
    end

    render json: response, status: :ok
  end

  def create_document
    document = current_user.documents.create!(document_params)

    response = Panko::Response.create do |r|
      { document: r.serializer(document, DocumentSerializer) }
    end

    render json: response, status: :created
  end

  def create_complementary_information
    complementary_information = current_user.complementary_informations.create!(complementary_information_params)

    response = Panko::Response.create do |r|
      { complementary_information: r.serializer(complementary_information, ComplementaryInformationSerializer) }
    end

    render json: response, status: :created
  end

  def create_absence
    absence = current_user.absences.create!(absence_params)

    response = Panko::Response.create do |r|
      { absence: r.serializer(absence, AbsenceSerializer) }
    end

    render json: response, status: :created
  end

  def destroy_absence
    absence = current_user.absences.destroy(params[:id])

    head :no_content
  end

  def destroy_document
    document = current_user.documents.destroy(params[:id])

    head :no_content
  end

  def students
    group = current_user.groups.find(params[:group_id])

    response = Panko::Response.create do |r|
      { group: r.serializer(group, GroupWithStudentsSerializer) }
    end

    render json: response, status: :ok
  end

  def groups_students
    students = current_user.students.preload(:group)

    response = Panko::Response.new(
      students: Panko::ArraySerializer.new(students, each_serializer: StudentSerializer)
    )

    render json: response, status: :ok
  end

  def groups
    groups = current_user.groups

    response = Panko::Response.new(
      groups: Panko::ArraySerializer.new(groups, each_serializer: GroupWithGradeTeachersPrincipalSerializer)
    )

    render json: response, status: :ok
  end

  def teachers
    teachers = current_user.teachers

    response = Panko::Response.new(
      teachers: Panko::ArraySerializer.new(teachers, each_serializer: TeachersSerializer)
    )

    render json: response, status: :ok
  end

  def destroy_complementary_information
    current_user.complementary_informations.destroy(params[:id])

    head :no_content
  end

  private

  def me_params
    params.require(:user).permit(:birthdate, :name, :surname, :ci, :address)
  end

  def me_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def document_params
    params.permit(:document_type, :certificate, :upload_date)
  end

  def complementary_information_params
    params.permit(:description, :date, :attachment)
  end

  def absence_params
    params.permit(:start_date, :end_date, :reason, :certificate)
  end
end
