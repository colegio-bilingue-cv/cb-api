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

  def type_scholarships
    student = Student.find(params[:student_id])
    type_scholarships = student.type_scholarships

    response = Panko::Response.new(
      student: {
        type_scholarships: Panko::ArraySerializer.new(type_scholarships, each_serializer: TypeScholarshipSerializer)
      }
    )

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def payment_methods
    student = Student.find(params[:student_id])
    student_payment_methods = student.student_payment_methods

    response = Panko::Response.new(
      student: {
        payment_methods: Panko::ArraySerializer.new(student_payment_methods, each_serializer: StudentPaymentMethodSerializer)
      }
    )

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def comments
    student = Student.find(params[:student_id])
    comments = student.comments

    response = Panko::Response.new(
      student: {
        comments: Panko::ArraySerializer.new(comments, each_serializer: CommentSerializer)
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
      :inscription_date, :starting_date, :contact, :contact_phone,
      payment_methods: [ :year ]
    )
  end
end
