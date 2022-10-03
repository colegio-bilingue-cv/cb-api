class StudentPaymentMethod < ApplicationRecord
  belongs_to :student
  belongs_to :payment_method

  validates :year, presence: true

  delegate :method, to: :payment_method, prefix: true

end
