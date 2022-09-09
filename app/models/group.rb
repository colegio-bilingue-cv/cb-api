class Group < ApplicationRecord
  belongs_to :Cicles
  has_many :Subgroups
end
