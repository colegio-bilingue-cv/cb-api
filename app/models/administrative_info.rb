class AdministrativeInfo < ApplicationRecord
  belongs_to :student
  has_many :payment_methods
  has_many :type_scholarships
  has_many :enrollment_commitments
  has_many :discounts
  has_many :resolutions
  has_many :comments
end
