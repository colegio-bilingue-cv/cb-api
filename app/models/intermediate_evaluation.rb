class IntermediateEvaluation < ApplicationRecord
  belongs_to :student
  belongs_to :group

  has_one_attached :report_card

  validates :starting_month, :ending_month, presence: true

  validate :month_period

  private

  def month_period
    if starting_month&.month &.> ending_month&.month
      errors.add(:starting_month, I18n.t('intermediate_evalution.errors.starting_month'))
    end
  end
end
