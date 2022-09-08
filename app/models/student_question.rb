class StudentQuestion < ApplicationRecord
  belongs_to :Category
  belongs_to :Student
end
