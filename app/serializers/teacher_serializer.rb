class TeacherSerializer < Panko::Serializer
  attributes :id, :name, :surname, :groups

  def groups
    teacher_groups = object.groups_by_role(:teacher)
    Panko::ArraySerializer.new(teacher_groups, each_serializer: GroupSerializer).to_a

  end
end
