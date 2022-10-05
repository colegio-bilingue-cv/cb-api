class Api::QuestionsController < ApplicationController
  def index
    questionCategories = Category.all
    serializer = Panko::ArraySerializer.new(questionCategories, each_serializer: CategorySerializer, context: {cicle_id: params[:cicle_id]})

    render json: serializer.to_json, status: :ok
  end
end
