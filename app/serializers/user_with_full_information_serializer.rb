class UserWithFullInformationSerializer < Panko::Serializer
  has_many :complementary_informations
  has_many :absences
  has_many :documents

  attributes :id, :email, :name, :surname, :ci, :address, :birthdate, :role, :starting_date

  def role
    object.roles.first.name
  end
end
