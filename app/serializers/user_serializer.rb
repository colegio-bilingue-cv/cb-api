class UserSerializer < Panko::Serializer
  attributes :id, :email, :name, :surname, :ci, :address, :birthdate, :role, :institution_start

  def role
    object.roles.first.name
  end
end
