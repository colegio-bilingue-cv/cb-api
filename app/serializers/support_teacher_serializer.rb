class SupportTeacherSerializer < Panko::Serializer
  attributes :id, :ci, :name, :surname

  has_many :support_teacher_groups, each_serializer: GroupWithGradeTeachersPrincipalSerializer, name: :groups
end
