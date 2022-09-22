class CiclesController < ApplicationController
    def index
        cicles = Cicle.all
        render json: Panko::ArraySerializer.new(cicles, each_serializer: CicleSerializer).to_json, status: :ok
    end
end
