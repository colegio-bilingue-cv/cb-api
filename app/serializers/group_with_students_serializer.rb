class GroupWithStudentsSerializer < Panko::Serializer
  attributes :id, :name, :year, :grade_name

  has_many :students

  def grade_name
    object.grade_name
  end
end
