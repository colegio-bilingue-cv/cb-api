class StudentSerializer < Panko::Serializer
  attributes :id, :ci, :surname, :name, :birthplace, :birthdate,
    :nationality, :schedule_start, :schedule_end, :tuition,
    :reference_number, :office, :status,
    :first_language, :address, :neighborhood, :medical_assurance,
    :emergency, :vaccine_name, :vaccine_expiration, :phone_number,
    :inscription_date, :starting_date, :contact, :contact_phone
end
