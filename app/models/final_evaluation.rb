class FinalEvaluation < ApplicationRecord
  belongs_to :student
  belongs_to :group

  has_one_attached :report_card

  enum status: [:pending, :passed, :failed], _default: :pending

  validates :status, presence: true

  delegate :name, :year, :grade_name, to: :group, prefix: true

end
