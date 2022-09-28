class Grade < ApplicationRecord
  belongs_to :cicle
  has_many :groups
end
