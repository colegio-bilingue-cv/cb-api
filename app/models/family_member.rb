class FamilyMember < ApplicationRecord
  has_and_belongs_to_many :students

  validates :ci, uniqueness: true, presence: true
  validates :role, :full_name, :birthdate, :birthplace, :nationality,
    :first_language, :marital_status, :cellphone, :email,
    :address, :neighborhood, :education_level, :occupation, :workplace,
    :workplace_neighbourhood, :workplace_phone, presence: true
end
