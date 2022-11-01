class DiscountSerializer < Panko::Serializer
  attributes :id, :percentage, :explanation, :start_date,
    :end_date, :resolution_description, :administrative_type,
    :resolution_url, :administrative_info_url

  def resolution_url
    object.resolution.url if object.resolution.attached?
  end

  def administrative_info_url
    object.administrative_info.url if object.administrative_info.attached?
  end
end
