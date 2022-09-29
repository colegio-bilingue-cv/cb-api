class Question < ApplicationRecord
  belongs_to :question_category
  has_many :cicles_question
  has_many :cicles, :through => :cicles_question
  has_many :question_answer

  validates :text, presence:true
end
