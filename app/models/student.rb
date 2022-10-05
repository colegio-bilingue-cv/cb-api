class Student < ApplicationRecord
  resourcify

  has_and_belongs_to_many :family_members
  has_many :student_type_scholarships
  has_many :type_scholarships, through: :student_type_scholarships
  has_many :student_payment_methods
  has_many :payment_methods, through: :student_payment_methods
  has_many :comments
  
  accepts_nested_attributes_for :student_payment_methods

  belongs_to :group
  has_many :answer
  enum status: [:pending, :active, :inactive]

  validates :ci, presence: true, length: { minimum: 8 }, uniqueness: true
  validates :address, :neighborhood, :name, :surname, :birthplace, :birthdate, :nationality, :first_language, presence: true
  validates :medical_assurance, :emergency, :vaccine_name, :vaccine_expiration, presence: true
end