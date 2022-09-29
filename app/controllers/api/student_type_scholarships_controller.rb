class Api::StudentTypeScholarshipsController < Api::BaseController
    def create
      raise ActiveRecord::RecordInvalid unless Student.exists?(student_type_scholarship_params[:student_id])
      raise ActiveRecord::RecordInvalid unless TypeScholarship.exists?(student_type_scholarship_params[:type_scholarship_id])

      student_type_scholarship = StudentTypeScholarship.create!(student_type_scholarship_params)
      
      response = Panko::Response.create do |r|
        { student_type_scholarship: r.serializer(student_type_scholarship, StudentTypeScholarshipSerializer) }
      end
      render json: response, status: :created
      
    rescue ActiveRecord::RecordInvalid => e
      p e.inspect
      render json: {}, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound
      render json: {}, status: :not_found  
    end
    
    private
    def student_type_scholarship_params
      params.require(:student_type_scholarship).permit(:student_id, :type_scholarship_id)
    end
    
  end
