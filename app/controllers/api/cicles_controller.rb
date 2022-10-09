class Api::CiclesController < ApplicationController
  def index
    cicles = Cicle.all
    response = Panko::Response.new(
      cicles: Panko::ArraySerializer.new(cicles, each_serializer: CicleSerializer).to_json, status: :ok
    )
  end
end
