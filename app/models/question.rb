class Question < ApplicationRecord
  belongs_to :question_category
  belongs_to :cicle
  belongs_to :question_answer

  validates question, presence:true
end
