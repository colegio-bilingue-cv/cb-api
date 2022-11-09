class AnswerSerializer < Panko::Serializer
  attributes :id, :answer

  has_one :question
  has_one :student
end
