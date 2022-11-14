class StudentTypeScholarship < ApplicationRecord
  belongs_to :student
  belongs_to :type_scholarship

  before_validation :set_date
  before_update :set_date

  validates :date, presence: true

  delegate :description, :scholarship, to: :type_scholarship, prefix: true

  private
  def set_date
    self.date = Date.today
  end
end
