class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :student

  validates :answer, presence: true

end
