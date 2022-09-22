class Cicle < ApplicationRecord
    has_many :questions
    has_many :grades
    belongs_to :question_answer
end
