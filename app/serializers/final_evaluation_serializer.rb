class FinalEvaluationSerializer < Panko::Serializer
  has_one :group
  attributes :id, :student_id, :status, :report_card_url

  def report_card_url
    object.report_card.url if object.report_card.attached?
  end

end
