class Question < ApplicationRecord
  belongs_to :question_category
  has_and_belongs_to_many :cicles
  has_many :question_answer

  validates :text, presence:true
end
