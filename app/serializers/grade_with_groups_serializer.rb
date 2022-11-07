class GradeWithGroupsSerializer < Panko::Serializer
  attributes :id, :name

  has_many :groups
end
