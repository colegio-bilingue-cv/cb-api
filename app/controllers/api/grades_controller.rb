class Api::GradesController < Api::BaseController
  def index
    grades = Grade.all

    response = Panko::Response.new(
      grades: Panko::ArraySerializer.new(grades, each_serializer: GradeWithGroupsSerializer)
    )

    render json: response, status: :ok
  end

  def show
    grade = Grade.find(params[:id])

    response = Panko::Response.create do |r|
      { grade: r.serializer(grade, GradeWithGroupsSerializer) }
    end

    render json: response, status: :ok
  end

end
