class Group < ApplicationRecord
  belongs_to :grade
  belongs_to :group
  has_many :students
end
