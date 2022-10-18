class Api::StudentTypeScholarshipsController < Api::BaseController
  def create
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(student_type_scholarship_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', TypeScholarship.to_s) unless TypeScholarship.exists?(student_type_scholarship_params[:type_scholarship_id])

    student_type_scholarship = StudentTypeScholarship.create!(student_type_scholarship_params)

    response = Panko::Response.create do |r|
      { student_type_scholarship: r.serializer(student_type_scholarship, StudentTypeScholarshipSerializer) }
    end

    render json: response, status: :created
  end

  def update
    raise ActiveRecord::RecordNotFound.new('', Student.to_s) unless Student.exists?(student_type_scholarship_params[:student_id])
    raise ActiveRecord::RecordNotFound.new('', TypeScholarship.to_s) unless TypeScholarship.exists?(student_type_scholarship_params[:type_scholarship_id])

    student_type_scholarship = StudentTypeScholarship.find(params[:id])
    student_type_scholarship.update!(student_type_scholarship_params)
    
    response = Panko::Response.create do |r|
      { student_type_scholarship: r.serializer(student_type_scholarship, StudentTypeScholarshipSerializer) }
    end

    render json: response, status: :ok
  end
  
  private

  def student_type_scholarship_params
    params.require(:student_type_scholarship).permit(:student_id, :type_scholarship_id)
  end

end
