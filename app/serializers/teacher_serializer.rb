class TeacherSerializer < Panko::Serializer
  attributes :id, :name, :surname

  has_many :teacher_groups, each_serializer: GroupWithGradeTeachersPrincipalSerializer, name: :groups
end
