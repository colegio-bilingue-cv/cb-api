class Cicle < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :students
  has_many :grades
end
