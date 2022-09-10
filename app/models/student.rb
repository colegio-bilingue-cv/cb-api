class Student < ApplicationRecord
  has_one :administrative_info

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :surname, :first_name, presence: true
  #validates :second_surname, :middle_name,
  validates :birthplace, :birthdate, :nacionality, :first_language, presence: true
  validates :address, :neighborhood, presence: true
  validates :medical_assurance, :emergency, :vaccine_name, :vaccine_expiration, presence: true
end
