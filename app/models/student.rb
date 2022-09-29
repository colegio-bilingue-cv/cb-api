class Student < ApplicationRecord
  has_and_belongs_to_many :family_members
  has_many :student_type_scholarships
  has_many :type_scholarships, through: :student_type_scholarships
  has_many :student_payment_methods
  has_many :payment_methods, through: :student_payment_methods
  has_many :comments
  
  accepts_nested_attributes_for :student_payment_methods

  enum status: [:pending, :active, :inactive]
  

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :address, :neighborhood,
    :name, :birthplace, :birthdate, :nationality, :first_language, presence: true

  validates :medical_assurance, :emergency, :vaccine_expiration, presence: true

end
