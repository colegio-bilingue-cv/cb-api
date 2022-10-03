class Api::QuestionsController < ApplicationController
  def index
    questionCategories = QuestionCategory.all

    for questionCategory in questionCategories do
      #questionCategory.name = "blabla"
      filteredQuestions = questionCategory.questions.joins(:cicles).where('cicles.id' => params[:cicle_id])
      filteredQuestions = filteredQuestions.where.not(question_category_id: nil)
      
      questionCategory.questions = filteredQuestions
    end

    render json: Panko::ArraySerializer.new(questionCategories, each_serializer: QuestionCategorySerializer).to_json, status: :ok
    #qs = QuestionCategory.find(2).questions.joins(:cicles).where('cicles.id' => 2)
    #render json: Panko::ArraySerializer.new(qs, each_serializer: QuestionSerializer).to_json, status: :ok
  end
end
