class Api::QuestionsController < ApplicationController
  def index
    cicle = Cicle.find(params[:cicle_id])
  end
end
