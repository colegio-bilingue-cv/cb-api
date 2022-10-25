class Group < ApplicationRecord
  belongs_to :grade
  has_many :students
  has_many :evaluations
  has_many :teachers, through: :user_groups, source: :users

  validates :name, :year, presence: true
end
