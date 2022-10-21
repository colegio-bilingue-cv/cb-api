class Api::CiclesController < ApplicationController
  def index
    cicles = Cicle.all
    
    response = Panko::Response.new(
      groups: Panko::ArraySerializer.new(cicles, each_serializer: CicleSerializer)
    )
    
    render json: response, status: :ok
  end
end
