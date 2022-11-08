class AbsenceSerializer < Panko::Serializer
  attributes :id, :start_date, :end_date, :reason, :certificate_url

  def certificate_url
    object.certificate.url if object.certificate.attached?
  end
  
end
