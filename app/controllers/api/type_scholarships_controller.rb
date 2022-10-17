class Api::TypeScholarshipsController < Api::BaseController
  def index
    type_scholarships = TypeScholarship.all

    response = Panko::Response.new(
      type_scholarships: Panko::ArraySerializer.new(type_scholarships, each_serializer: TypeScholarshipSerializer)
    )

    render json: response, status: :ok
  end

  def create
    type_scholarship = TypeScholarship.create!(type_scholarship_params)

    response = Panko::Response.create do |r|
      { type_scholarship: r.serializer(type_scholarship, TypeScholarshipSerializer) }
    end

      render json: response, status: :created
  end

  def update
    type_scholarship = TypeScholarship.find(params[:id])
    type_scholarship.update!(type_scholarship_params)

    response = Panko::Response.create do |r|
      { type_scholarship: r.serializer(type_scholarship, TypeScholarshipSerializer) }
    end

    render json: response, status: :ok
  end

  private

  def type_scholarship_params
    params.require(:type_scholarship).permit(:description, :scholarship)
  end
end
