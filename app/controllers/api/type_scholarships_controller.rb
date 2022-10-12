class Api::TypeScholarshipsController < Api::BaseController
  def index
    type_scholarships = TypeScholarship.all

    response = Panko::Response.new(
      type_scholarships: Panko::ArraySerializer.new(type_scholarships, each_serializer: TypeScholarshipSerializer)
    )

    render json: response, status: :ok
  end

  def update
    type_scholarship = TypeScholarship.find(params[:id])
    type_scholarship.update!(type_scholarship_params)

    response = Panko::Response.create do |r|
      { type_scholarship: r.serializer(type_scholarship, TypeScholarshipSerializer) }
    end

    render json: response, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: :not_found
  rescue ActiveRecord::RecordInvalid
    render json: {}, status: :unprocessable_entity
  end

  private

  def type_scholarship_params
    params.require(:type_scholarship).permit(:description, :scholarship, :id)
  end
end