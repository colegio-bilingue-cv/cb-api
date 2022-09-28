class Cicle < ApplicationRecord
    has_many :questions, through: :cicles_questions
    has_many :grades
    has_many :question_answer
end
