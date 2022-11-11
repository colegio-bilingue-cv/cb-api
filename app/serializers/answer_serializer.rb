class AnswerSerializer < Panko::Serializer
  attributes :id, :answer

  has_one :question

end
