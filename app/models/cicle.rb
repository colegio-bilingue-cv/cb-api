class Cicle < ApplicationRecord
    has_many :cicle_questions
    has_many :questions, :through => :cicle_questions
    has_many :grades
    has_many :question_answer
end
