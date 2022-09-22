class Student < ApplicationRecord
  has_and_belongs_to_many :family_members
  has_and_belongs_to_many :student_type_scholarship_agreement_types
  enum status: [:pending, :active, :inactive]

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :address, :neighborhood,
    :name, :birthplace, :birthdate, :nationality, :first_language, presence: true

  validates :medical_assurance, :emergency, :vaccine_expiration, presence: true

end
