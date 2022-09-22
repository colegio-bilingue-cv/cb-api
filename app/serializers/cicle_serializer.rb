class CicleSerializer < Panko::Serializer
    attributes :name

    has_many :question_categories
end
  