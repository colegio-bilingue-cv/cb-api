class FinalEvaluation < ApplicationRecord
  belongs_to :student
  belongs_to :group

  enum status: [:pending, :passed, :failed], _default: :pending

  validates :status, presence: true

end
