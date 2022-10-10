class Discount < ApplicationRecord
  belongs_to :student

  enum explanation: [:sibling, :resolution]
  enum administrative_type: [:direction, :social_assistance]

  validates :percentage, :explanation, :start_date, :end_date, presence: true
  validate :validation_date

  private

  def validation_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, I18n.t('discount.validations.validity_date'))
    end
  end
end
