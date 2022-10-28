class IntermediateEvaluation < ApplicationRecord
  belongs_to :student
  belongs_to :group

  validates :starting_month, :ending_month, presence: true

  validate :month_period

  delegate :name, :year, to: :group, prefix: true

  private

  def month_period
    if starting_month&.month &.> ending_month&.month
      errors.add(:starting_month, I18n.t('intermediate_evalution.errors.starting_month'))
    end
  end
end
