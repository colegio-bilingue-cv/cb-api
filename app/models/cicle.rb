class Cicle < ApplicationRecord
  has_many :questions
  has_many :students
  has_many :grades
end
