class QuestionCategorySerializer < Panko::Serializer
  attributes :name

  has_many :questions
end
