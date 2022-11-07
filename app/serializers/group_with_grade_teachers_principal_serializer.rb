class GroupWithGradeTeachersPrincipalSerializer < Panko::Serializer
  attributes :id, :name, :year

  has_one :grade
  has_one :principal, serializer: UserSerializer
  has_many :teachers, each_serializer: UserSerializer
  has_one :support_teacher, serializer: UserSerializer
end
