class TeacherWithGroupTeachersPrincipalSerializer < Panko::Serializer
  attributes :id, :ci, :name, :surname

  has_many :teacher_groups, each_serializer: GroupWithGradeTeachersPrincipalSerializer, name: :groups
end
