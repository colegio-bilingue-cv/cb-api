class TypeScholarship < ApplicationRecord
  has_many :student_type_scholarships
  has_many :students, through: :student_type_scholarships
  enum type: [:bidding, :subsidized, :agreement ,:special]
  validates :type, presence: true
  validates :description, presence: true, if: :bidding_or_agreement?

  def bidding_or_agreement?
    type==:bidding||type==:agreement
  end

end
