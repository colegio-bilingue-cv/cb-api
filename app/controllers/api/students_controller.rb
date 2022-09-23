class Api::StudentsController < Api::BaseController

  def index
    students = Student.all

    response = Panko::Response.new(
      students: Panko::ArraySerializer.new(students, each_serializer: StudentSerializer)
    )

    render json: response, status: :ok
  end

  def show
    student = Student.find(params[:id])

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def create
    student = Student.create!(student_params)

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def update
    student = Student.find(params[:id])
    student.update!(student_params)

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  def family_members
    student = Student.find(params[:student_id])
    family_members = student.family_members

    response = Panko::Response.new(
      student: {
        family_members: Panko::ArraySerializer.new(family_members, each_serializer: FamilyMemberSerializer)
      }
    )

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end


  def student_type_scholarship_agreement_types
    student = Student.find(params[:student_id])
    student_type_scholarship_agreement_types = student.student_type_scholarship_agreement_types

    response = Panko::Response.new(
      student: {
        student_type_scholarship_agreement_types: Panko::ArraySerializer.new(student_type_scholarship_agreement_types, each_serializer: StudentTypeScholarshipAgreementTypeSerializer) #debo hacer un StudentTypeScholarshipAgreementTypeSerializer (?) duda
      }
    )

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
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