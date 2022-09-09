class Cicle < ApplicationRecord
  has_many :groups
  has_many :questions
end
