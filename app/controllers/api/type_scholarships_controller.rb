class Api::TypeScholarshipsController < Api::BaseController
    def index
      type_scholarships = TypeScholarship.all
        
      response = Panko::Response.new(
        type_scholarships: Panko::ArraySerializer.new(type_scholarships, each_serializer: TypeScholarshipSerializer)
      )
      render json: response, status: :ok
    end
    
  private
  def type_scholarship_params
    params.require(:type_scholarship).permit(:description, :type_s
    )
  end
end  
