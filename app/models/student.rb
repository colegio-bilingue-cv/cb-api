class Student < ApplicationRecord
  enum status: [:pending, :active, :inactive]

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :address, :neighborhood,
    :name, :birthplace, :birthdate, :nationality, :first_language, presence: true

  validates :medical_assurance, :emergency, :vaccine_expiration, presence: true

end