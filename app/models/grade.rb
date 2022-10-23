class Grade < ApplicationRecord
  belongs_to :cicle
  has_many :groups

  validates :name, presence: true
end
