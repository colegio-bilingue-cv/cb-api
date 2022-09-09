class Subgroup < ApplicationRecord
  belongs_to :Group
  has_many :Students
end
