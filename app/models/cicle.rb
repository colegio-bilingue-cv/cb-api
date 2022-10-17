class Cicle < ApplicationRecord
    has_and_belongs_to_many :questions
    has_many :grades
    has_many :answers
    has_many :students
end
