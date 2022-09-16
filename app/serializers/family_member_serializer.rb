class FamilyMemberSerializer < Panko::Serializer
  attributes :id, :ci, :role, :full_name, :birthdate, :birthplace, :nationality,
    :first_language, :marital_status, :cellphone, :email,
    :address, :neighborhood, :education_level, :occupation, :workplace,
    :workplace_neighbourhood, :workplace_phone
end