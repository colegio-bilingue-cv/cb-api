class UserGroupSerializer < Panko::Serializer
  has_one :user
  has_one :group
end
