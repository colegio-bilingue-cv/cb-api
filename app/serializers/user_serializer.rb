class UserSerializer < Panko::Serializer
  attributes :id, :email, :password, :name, :surname, :ci, :address, :birthdate
end
