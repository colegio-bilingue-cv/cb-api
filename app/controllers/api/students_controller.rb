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
  end

  def create
    student = Student.create!(student_params)

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :created
  end

  def update
    student = Student.find(params[:id])
    student.update!(student_params)

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :ok
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
  end

  def type_scholarships
    student = Student.find(params[:student_id])
    student_type_scholarships = student.student_type_scholarships

    response = Panko::Response.new(
      student: {
        student_type_scholarships: Panko::ArraySerializer.new(student_type_scholarships, each_serializer: StudentTypeScholarshipSerializer)
      }
    )

    render json: response, status: :ok
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
  end

  def discounts
    student = Student.find(params[:student_id])
    discounts = student.discounts

    response = Panko::Response.new(
      student: {
        discounts: Panko::ArraySerializer.new(discounts, each_serializer: DiscountSerializer)
      }
    )

    render json: response, status: :ok
  end

  def activate
    student = Student.find(params[:student_id])

    student.update!(activate_params)
    student.activate!

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :ok
  rescue StudentsActivation::StudentActivationError => e
    response = Panko::Response.create do |r|
      { error: r.serializer(ErrorMessage.build_invalid_student_activation(e), ErrorSerializer) }
    end

    render json: response, status: :unprocessable_entity
  end

  private

  def student_params
    params.require(:student).permit(:ci, :surname,
      :name, :birthplace, :birthdate, :nationality, :schedule_start,
      :schedule_end, :tuition, :office,
      :first_language, :address, :neighborhood, :medical_assurance,
      :emergency, :vaccine_name, :vaccine_expiration, :phone_number,
      :inscription_date, :starting_date, :contact, :contact_phone, :enrollment_commitment,
      payment_methods: [ :year ]
    )
  end

  def activate_params
    params.require(:student).permit(:reference_number)
  end
end
