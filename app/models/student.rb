class Student < ApplicationRecord
  validates :ci, presence: true, length: {minimum: 8}, uniqueness: true
  validates :surname, :first_name, presence: true
  #validates :second_surname, :middle_name, 
  validates :birthplace, :birthdate, :nacionality, :first_language, presence: true
  validates :address, :neighborhood, presence: true
  validares :medical_assurance, :emergency, :vaccine_name, :vaccine_expiry, presence: true
end
