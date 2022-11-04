class StudentPaymentMethodSerializer < Panko::Serializer
  attributes :id, :year, :method, :payment_method_id, :student_id, :annual_payment_url

  def method
    object.payment_method_method
  end

  def annual_payment_url
    object.annual_payment.url if object.annual_payment.attached?
  end

end
