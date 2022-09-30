class StudentTypeScholarship < ApplicationRecord
  belongs_to :student
  belongs_to :type_scholarship

  before_validation :set_date
  
  validates :date, presence: true

  private

  def set_date
    self.date = Date.today
  end
end
