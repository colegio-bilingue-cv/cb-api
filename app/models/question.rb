class Question < ApplicationRecord
  belongs_to :category
  belongs_to :cicle
  has_many :answers
  has_many :students, through: :answers

  validates :text, presence: true
end
