class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :certificate

  enum explanation: [:project, :evaluation]

  validates :document_type, presence: true

end
