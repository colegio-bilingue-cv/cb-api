class QuestionsController < ApplicationController
    def index
        cicles = Cicle.all
        render json: Panko::ArraySerializer.new(questions, each_serializer: QuestionSerializer).to_json, status: :ok
    end
end
