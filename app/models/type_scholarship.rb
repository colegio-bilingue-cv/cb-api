class TypeScholarship < ApplicationRecord
  has_many :student_type_scholarships
  has_many :students, through: :student_type_scholarships

  enum scholarship: [:bidding, :subsidized, :agreement, :special]

  before_update  :blank_description

  validates :scholarship, presence: true
  validates :description, presence: true, uniqueness: { scope: :scholarship }, if: :bidding_or_agreement?
  validates :description, presence: true, if: :bidding_or_agreement?

  private

  def bidding_or_agreement?
    scholarship.blank? || [:bidding, :agreement].include?(scholarship.to_sym)
  end

  def blank_description
    if scholarship.blank? || [:subsidized, :special].include?(scholarship.to_sym)
      description = nil
    end
  end
end
