class StudentSerializer < Panko::Serializer
  attributes :id, :ci, :surname, :name, :birthplace, :birthdate,
    :nationality, :schedule_start, :schedule_end, :tuition,
    :reference_number, :office, :status,
    :first_language, :address, :neighborhood, :medical_assurance,
    :emergency, :vaccine_name, :vaccine_expiration, :phone_number,
    :inscription_date, :starting_date, :contact, :contact_phone,
    :enrollment_commitment_url

  has_one :group

  def enrollment_commitment_url
    object.enrollment_commitment.url if object.enrollment_commitment.attached?
  end
end
