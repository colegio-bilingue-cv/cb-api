class TeachersSerializer < Panko::Serializer
  attributes :id, :ci, :name, :surname

  has_many :teacher_groups, each_serializer: GroupWithGradesSerializer, name: :groups
end
