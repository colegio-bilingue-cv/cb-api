class Group < ApplicationRecord
  belongs_to :grade
  has_many :students
  has_many :evaluations
  has_many :user_groups
  has_many :users, through: :user_groups

  validates :name, :year, presence: true
end
