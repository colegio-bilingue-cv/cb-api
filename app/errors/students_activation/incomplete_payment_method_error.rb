class StudentsActivation::IncompletePaymentMethodError < StudentsActivation::StudentActivationError
  def message_key
    'student.activation_errors.incomplete_payment_method'
  end
end
