class PaymentMethod < ApplicationRecord
  has_many :student_payment_methods
  has_many :students, through: :student_payment_methods

  validates :method, presence: true, uniqueness: true
end
