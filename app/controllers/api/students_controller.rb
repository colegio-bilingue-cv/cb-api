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
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  end

  def activate    
    student = Student.find(params[:student_id])
    messages = []; #TODO aca habria que ir agregando lo que falte para mandar con el error
    
    if !validateStudentData(student)
      messages.push("Falta completar información básica del alumno.")
    end
    if !validateFamily(student)
      messages.push("Falta completar información sobre los tutores del alumno.")
    end
    if !validateComplementaryInfo(student)
      messages.push("Falta completar información complementaria del alumno.")
    end
    if !validatePaymentMethod(student)
      messages.push("Falta agregar métodos de pago para el alumno.")
    end

    if messages.length() == 0
      student.reference_number = params[:reference_number]
      student.status = 1

      student.save

      render json: {}, status: :ok
    else
      render json: { conflicts: messages}, status: :conflict
    end 
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

  def validateStudentData(student)
  missingData = []

    if !student['schedule_start']
      return false
    end
    if !student['schedule_end']
      return false
    end
    if !student['tuition']
      return false
    end
    if !student['office']
      return false
    end
    if !student['emergency']
      return false
    end
    if !student['vaccine_name']
      return false
    end
    if !student['vaccine_expiration']
      return false
    end
    if !student['phone_number']
      return false
    end
    if !student['inscription_date']
      return false
    end
    if !student['starting_date']
      return false
    end
    if !student['contact']
      return false
    end
    if !student['contact_phone']
      return false
    end

    return true
  end
  def validateFamily(student)
    familyMembers = student.family_members
    return familyMembers.length() > 0
  end
  def validateComplementaryInfo(student)
    cicle = student.group.grade.cicle
    totalQuestions = cicle.questions
    answeredQuestions = student.answers.where('cicle_id' => cicle.id)

    return totalQuestions.length() == answeredQuestions.length()
  end
  def validatePaymentMethod(student)
    return student.student_payment_methods.length > 0
  end

  private
  def student_params
    params.require(:student).permit(:ci, :surname,
      :name, :birthplace, :birthdate, :nationality, :schedule_start, :schedule_end, :tuition,
      :reference_number, :office, :status,
      :first_language, :address, :neighborhood, :medical_assurance,
      :emergency, :vaccine_name, :vaccine_expiration, :phone_number,
      :inscription_date, :starting_date, :contact, :contact_phone, :group_id,
      payment_methods: [ :year ]
    )
  end
end