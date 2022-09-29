class TypeScholarship < ApplicationRecord
  has_many :student_type_scholarships
  has_many :students, through: :student_type_scholarships
  enum type_s: [:bidding, :subsidized, :agreement ,:special]
  validates :type_s, presence: true
  validates :description, presence: true, if: :bidding_or_agreement?

  def bidding_or_agreement?
    type_s==:bidding||type_s==:agreement
  end

end
