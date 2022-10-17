class GroupSerializer < Panko::Serializer
  attributes :id, :name, :year

  has_one :grade
end
