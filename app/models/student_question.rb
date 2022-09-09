class StudentQuestion < ApplicationRecord
  belongs_to :category
  belongs_to :student
end
