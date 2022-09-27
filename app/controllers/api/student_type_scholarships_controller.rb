class Api::StudentTypeScholarshipsController < Api::BaseController
    def create
      raise ActiveRecord::RecordInvalid unless Student.exists?(student_type_scholarship_params[:student_id])
      raise ActiveRecord::RecordInvalid unless TypeScholarship.exists?(student_type_scholarship_params[:type_scholarship_id])

      student_type_scholarship = StudentTypeScholarship.new(student_type_scholarship_params)
      student_type_scholarship.student_id = params[:student_id]
      student_type_scholarship.type_scholarship_id = params[:type_scholarship_id]
      student_type_scholarship.save!
  
      response = Panko::Response.create do |r|
        { student_type_scholarship: r.serializer(student_type_scholarship, StudentTypeScholarshipSerializer) }
      end
  
      render json: response, status: :created
     
    rescue ActiveRecord::RecordInvalid
      render json: {}, status: :unprocessable_entity
    end
    
    private
    def student_type_scholarship_params
      params.require(:student_type_scholarship).permit(:student_id, :type_scholarship_id)
    end
    
  end
