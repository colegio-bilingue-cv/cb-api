class UserSerializer < Panko::Serializer
  attributes :id, :email, :password, :name, :surname, :ci, :address, :birthdate, :role

  def role
    object.roles.first.name
  end
end
