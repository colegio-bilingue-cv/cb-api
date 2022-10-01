class StudentPaymentMethodSerializer < Panko::Serializer
  attributes :year, :method, :payment_method_id

  def method
    object.payment_method_method
  end

  def payment_method_id
    object.payment_method_id
  end
end
