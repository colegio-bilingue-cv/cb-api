class TypeScholarship < ApplicationRecord
  has_many :student_type_scholarships
  has_many :students, through: :student_type_scholarships

  enum scholarship: [:bidding, :subsidized, :agreement, :special]

  before_update  :blank_description

  validates :scholarship, presence: true
  validates :description, presence: true, if: :bidding_or_agreement?

  private

  def bidding_or_agreement?
    [:bidding, :agreement].include?(scholarship)
  end

  def blank_description
    if [:subsidized, :special].include?(scholarship)
      description = nil
    end
  end
end
