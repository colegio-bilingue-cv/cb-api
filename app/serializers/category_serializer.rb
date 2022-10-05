class CategorySerializer < Panko::Serializer
  attributes :name

has_many :questions

  def questions
    object.questions_of_cicle(context[:cicle_id])
  end
end
