class StudentPaymentMethodSerializer < Panko::Serializer
  attributes :year, :method, :payment_method_id, :student_id

  def method
    object.payment_method_method
  end

end
