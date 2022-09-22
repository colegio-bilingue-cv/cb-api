class QuestionAnswer < ApplicationRecord
  has_one :cicle
  has_one :question
  has_one :student

  validates answer, presence:true
end
