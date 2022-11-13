class RelevantEventSerializer < Panko::Serializer
  has_one :user

  attributes :id, :date, :title, :description, :event_type, :attachment_url

  def attachment_url
    object.attachment.url if object.attachment.attached?
  end

end
