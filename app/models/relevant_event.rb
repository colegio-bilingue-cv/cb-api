class RelevantEvent < ApplicationRecord
  belongs_to :user
  belongs_to :student

  has_one_attached :attachment

  enum event_type: [:event, :family_situation, :school_situation, :external_report]

  validates :date, :title, presence: true

end
