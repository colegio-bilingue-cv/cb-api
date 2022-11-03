class TeacherSerializer < Panko::Serializer
  attributes :id, :name, :surname

  has_many :groups
end
