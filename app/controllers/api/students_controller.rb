class Api::StudentsController < Api::BaseController
  def create
    student = Student.create!(student_params)

    render json: StudentSerializer.new.serialize_to_json(student), status: :created
  end

  def show
    student = Student.find(params[:id])

    render json: StudentSerializer.new.serialize_to_json(student), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def update
    student = Student.find(params[:id])
    student.update(student_params)

    render json: StudentSerializer.new.serialize_to_json(student), status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def index
    students = Student.all
    render json: Panko::ArraySerializer.new(students, each_serializer: StudentSerializer).to_json, status: :ok
  end

  def family_members
    student = Student.find(params[:student_id])
    family_members = student.family_members.all
    render json: Panko::ArraySerializer.new(family_members, each_serializer: FamilyMemberSerializer).to_json, status: :ok
  end

  private

  def student_params
    params.require(:student).permit(:ci, :surname,
      :name, :birthplace, :birthdate, :nationality, :schedule_start, :schedule_end, :tuition,
      :reference_number, :office, :status,
      :first_language, :address, :neighborhood, :medical_assurance,
      :emergency, :vaccine_name, :vaccine_expiration, :phone_number,
      :inscription_date, :starting_date, :contact, :contact_phone
    )
  end
end