class ComplementaryInformation < ApplicationRecord
  belongs_to :user

  has_one_attached :attachment

  validates :description, presence: true
end
