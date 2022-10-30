class IntermediateEvaluationSerializer < Panko::Serializer
  attributes :id, :student_id, :group_id, :group_name, :year, :starting_month, :ending_month, :report_card_url, :grade_name

  def group_name
    object.group_name
  end

  def year
    object.group_year
  end

  def report_card_url
    object.report_card.url if object.report_card.attached?
  end

  def grade_name
    object.group.grade_name
  end

end
