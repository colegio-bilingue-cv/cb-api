class GroupSerializer < Panko::Serializer
  attributes :id, :name, :year, :grade

  def grade
    object.grade.name
  end
end
