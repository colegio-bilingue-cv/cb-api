class PrincipalSerializer < Panko::Serializer
  attributes :id, :ci, :name, :surname

  has_many :principal_groups, each_serializer: GroupWithGradeTeachersPrincipalSerializer, name: :groups
end
