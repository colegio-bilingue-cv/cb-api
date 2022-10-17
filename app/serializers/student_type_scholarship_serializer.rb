class StudentTypeScholarshipSerializer < Panko::Serializer
  attributes :id, :date, :student_id, :type_scholarship_id, :description, :scholarship

  def description
    object.type_scholarship_description
  end

  def scholarship
    object.type_scholarship_scholarship
  end

end
