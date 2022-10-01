class Comment < ApplicationRecord
  belongs_to :student
  validates :text, presence: true
end
