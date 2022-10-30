class Group < ApplicationRecord
  belongs_to :grade
  has_many :students
  has_many :evaluations

  validates :name, :year, presence: true

  delegate :name, to: :grade, prefix: true
end
