class TypeScholarship < ApplicationRecord
  has_many :student_type_scholarships
  has_many :students, through: :student_type_scholarships
  enum type: [:bidding, :subsidized, :agreement ,:special]
  validates :description, uniqueness: true, presence: true
end
