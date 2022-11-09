class GroupWithGradeTeachersPrincipalSerializer < Panko::Serializer
  attributes :id, :name, :year

  has_one :grade
  has_many :principals, serializer: UserSerializer
  has_many :teachers, each_serializer: UserSerializer
  has_many :support_teachers, serializer: UserSerializer
end
