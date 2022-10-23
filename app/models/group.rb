class Group < ApplicationRecord
  belongs_to :grade
  has_many :students

  validates :name, :year, presence: true
end
