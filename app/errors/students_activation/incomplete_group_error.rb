class StudentsActivation::IncompleteGroupError < StudentsActivation::StudentActivationError
  def message_key
    'student.activation_errors.incomplete_group_error'
  end
end
