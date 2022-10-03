class QuestionSerializer < Panko::Serializer
    attributes :id, :text, :question_category_id
  end
  