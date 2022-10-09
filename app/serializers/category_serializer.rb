class CategorySerializer < Panko::Serializer
  attributes :name, :questions

  def questions
    questionsByCicle = object.questions_of_cicle(context[:cicle_id])
    Panko::ArraySerializer.new(questionsByCicle, each_serializer: QuestionSerializer).to_a
  end
end
