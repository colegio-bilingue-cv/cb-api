class TypeScholarship < ApplicationRecord
  has_many :student_type_scholarships
  has_many :students, through: :student_type_scholarships

  enum scholarship: [:bidding, :subsidized, :agreement, :special]

  validates :scholarship, presence: true
  validates :description, presence: true, if: :bidding_or_agreement?

  def bidding_or_agreement?
    [:bidding, :agreement].include?(scholarship)
  end

end
