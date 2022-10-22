class TeacherSerializer < Panko::Serializer
  attributes :id, :name, :surname, :groups

  def groups
    groupsByTeacher = object.groups()
    Panko::ArraySerializer.new(groupsByTeacher, each_serializer: GroupSerializer).to_a
  end
end
