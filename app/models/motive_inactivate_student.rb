class MotiveInactivateStudent < ApplicationRecord
  belongs_to :student

  validates :motive, :last_day, :description, presence: true
end
