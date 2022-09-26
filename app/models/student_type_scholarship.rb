class StudentTypeScholarship < ApplicationRecord
  belongs_to :student
  belongs_to :type_scholarship
  validates :date, presence: true
  before_create :set_date

  private
  def set_date
    self.date =  Time.now()
  end
end
