class GradeSerializer < Panko::Serializer
  attributes :id, :name

  has_many :groups
end
