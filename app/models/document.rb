class Document < ApplicationRecord
  belongs_to :user
  has_one_attached :certificate

  validates :document_type, presence: true

end
