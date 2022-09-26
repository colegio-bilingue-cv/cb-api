class Api::StudentTypeScholarshipController < Api::BaseController
    def create
      student = Student.find(params[:student_id])
      student_type_scholarship= StudentTypeScholarship.new(student_type_scholarship_params)
  
      student_type_scholarship.student_id = params[:student_id]
  
      p student_type_scholarship.inspect
      student_type_scholarship.save!
  
      response = student_type_scholarship
      #response = Panko::Response.create do |r|
      #  { student_type_scholarship_option: r.serializer(student_type_scholarship_option, StudentTypeOptionSerializer) }
      #end
  
      render json: response, status: :created
     
    #rescue ActiveRecord::RecordInvalid
    #  render json: {}, status: :unprocessable_entity
    end
    
    private
    def student_type_scholarship_params #ver aca de poner lo de time.now(), creo
      params.require(:student_type_scholarship).permit(:type_scholarship_id)
    end
    
  end
