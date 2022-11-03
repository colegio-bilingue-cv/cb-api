class GroupSerializer < Panko::Serializer
  attributes :id, :name, :year, :grade_name

  def grade_name
    object.grade_name
  end
end
