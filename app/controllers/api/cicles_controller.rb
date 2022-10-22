class Api::CiclesController < Api::BaseController
  def index
    cicles = Cicle.all

    response = Panko::Response.new(
      cicles: Panko::ArraySerializer.new(cicles, each_serializer: CicleSerializer)
    )

    render json: response, status: :ok
  end

end
