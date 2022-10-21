class Question < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :cicles
  has_many :answers

  validates :text, presence: true
end