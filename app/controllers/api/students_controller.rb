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

  def activate    
    student = Student.find(params[:student_id])
    missingData = []; #TODO aca habria que ir agregando lo que falte para mandar con el error

    #:reference_number,  :status,
    #checkStudentData(student)
    #checkFamily(student)
    checkComplementaryInfo(student)

    render json: {
      message: "Se ha activado al alumno."
    }, status: :ok


    #chequear que esta toda la info basica del alumno seteada-----
    #chequear que el usuario tiene los datos de almenos un tutor-------
    #TODO chequear que hay almenos una forma de pago
    #TODO checkear que todas las preguntas de la informacion fueron completadas

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

  def checkStudentData(student)  
    #TODO reemplazar por errores del modulo de errores
    if !student['schedule_start']
      raise "Falta llenar campos 1"
    end
    if !student['schedule_end']
      raise "Falta llenar campos 2"
    end
    if !student['tuition']
      raise "Falta llenar campos 3"
    end
    if !student['office']
      raise "Falta llenar campos 4"
    end
    if !student['emergency']
      raise "Falta llenar campos 5"
    end
    if !student['vaccine_name']
      raise "Falta llenar campos 6"
    end
    if !student['vaccine_expiration']
      raise "Falta llenar campos 7"
    end
    if !student['phone_number']
      raise "Falta llenar campos 8"
    end
    if !student['inscription_date']
      raise "Falta llenar campos 9"
    end
    if !student['starting_date']
      raise "Falta llenar campos 10"
    end
    if !student['contact']
      raise "Falta llenar campos 11"
    end
    if !student['contact_phone']
      raise "Falta llenar campos 12"
    end
  end
  def checkFamily(student)
    #TODO poner los errores del manejador
    familyMembers = student.family_members
    if familyMembers.length() == 0 
      raise "Faltan padres"
    end
  end
  def checkComplementaryInfo(student)
    cicle = student.group.grade.cicle
    totalQuestions = cicle.questions
    answeredQuestions = student.question_answers.where(cicle: cicle.id)

    #obtengo el ciclo del alumno
    #obtengo todas las preguntas para ese ciclo
    #obtengo las respuestas para el estudiante y el ciclo

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