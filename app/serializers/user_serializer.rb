class UserSerializer < Panko::Serializer
  attributes :id, :email, :name, :surname, :ci, :address, :birthdate, :role, :starting_date

  def role
    object.roles.first.name
  end
end
