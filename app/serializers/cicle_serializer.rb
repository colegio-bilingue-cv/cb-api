class CicleSerializer < Panko::Serializer
    attributes :id, :name

    has_many :questions
end
  