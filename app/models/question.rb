class Question < ApplicationRecord
  belongs_to :question_category
  has_many :cicle_questions
  has_many :cicles, through: :cicle_questions
  has_many :question_answer

  validates :text, presence:true
end
