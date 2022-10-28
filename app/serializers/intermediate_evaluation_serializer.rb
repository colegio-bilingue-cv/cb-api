class IntermediateEvaluationSerializer < Panko::Serializer
  attributes :id, :student_id, :group_id, :group_name, :year, :starting_month, :ending_month

  def group_name
    object.group_name
  end

  def year
    object.group_year
  end

end
