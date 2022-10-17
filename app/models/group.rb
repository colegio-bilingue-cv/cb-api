class Group < ApplicationRecord
  belongs_to :grade
  has_many :students
  
  has_many :nextGroup, foreign_key: "group_id", class_name: "Group"
  belongs_to :previousGroup, optional: true, class_name: "Group"

  validates :name, presence: true, uniqueness: true
  validates :year, :grade_id, presence: true
end
