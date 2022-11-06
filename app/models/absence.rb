class Absence < ApplicationRecord
  belongs_to :user

  has_one_attached :certificate

  validates :start_date, :end_date, presence: true

  validate :validation_date

  private

  def validation_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, I18n.t('absence.validations.validity_date'))
    end
  end
end
