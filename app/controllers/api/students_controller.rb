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
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) if student_params[:group_id].present? && !Group.exists?(student_params[:group_id])
    student = Student.create!(student_params)

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :created
  end

  def update
    raise ActiveRecord::RecordNotFound.new('', Group.to_s) if student_params[:group_id].present? && !Group.exists?(student_params[:group_id])
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

  def answers
    student = Student.find(params[:student_id])
    danswers = student.answers

    response = Panko::Response.new(
      student: {
        answers: Panko::ArraySerializer.new(answers, each_serializer: AnswerSerializer)
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

  def inactive
    students = Student.inactive

    response = Panko::Response.new(
      students: Panko::ArraySerializer.new(students, each_serializer: StudentWithMotiveInactiveSerializer)
    )
    render json: response, status: :ok
  end

  def evaluations
    student = Student.find(params[:student_id])
    final_evaluation = student.final_evaluations
    intermediate_evaluation = student.intermediate_evaluations

    response = Panko::Response.new(
      student: {
        final_evaluations: Panko::ArraySerializer.new(final_evaluation, each_serializer: FinalEvaluationSerializer),
        intermediate_evaluations: Panko::ArraySerializer.new(intermediate_evaluation, each_serializer: IntermediateEvaluationSerializer)
      }
    )

    render json: response, status: :ok
  end

  def active
    students = Student.active
    response = Panko::Response.new(
      students: Panko::ArraySerializer.new(students, each_serializer: StudentSerializer)
    )

    render json: response, status: :ok
  end

  def pending
    students = Student.pending

    response = Panko::Response.new(
      students: Panko::ArraySerializer.new(students, each_serializer: StudentSerializer)
    )

    render json: response, status: :ok
  end


  def deactivate
    student = Student.find(params[:student_id])
    motive_inactivate_student = student.motive_inactivate_students.create!(deactivate_params)
    student.deactivate!

    response = Panko::Response.create do |r|
      { student: r.serializer(student, StudentSerializer) }
    end

    render json: response, status: :ok
  end

  private

  def student_params
    params.permit(:ci, :surname,
      :name, :birthplace, :birthdate, :nationality, :schedule_start, :schedule_end, :tuition,
      :reference_number, :office,
      :first_language, :address, :neighborhood, :medical_assurance,
      :emergency, :vaccine_name, :vaccine_expiration, :phone_number,
      :inscription_date, :starting_date, :contact, :contact_phone, :enrollment_commitment, :group_id
    )
  end

  def activate_params
    params.require(:student).permit(:reference_number)
  end

  def deactivate_params
    params.permit(:motive, :last_day, :description)
  end

end
