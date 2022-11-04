class DocumentSerializer < Panko::Serializer
  attributes :id, :document_type, :upload_date, :certificate_url

  def certificate_url
    object.certificate.url if object.certificate.attached?
  end

end
