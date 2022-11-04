class ComplementaryInformationSerializer < Panko::Serializer
  attributes :id, :date, :description, :attachment_url

  def attachment_url
    object.attachment.url if object.attachment.attached?
  end
end
