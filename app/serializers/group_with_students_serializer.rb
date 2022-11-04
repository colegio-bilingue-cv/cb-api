class GroupWithStudentsSerializer < Panko::Serializer
  attributes :id, :name, :year, :grade

  def grade
    object.grade.name
  end

  has_many :students
end
