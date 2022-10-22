class StudentsActivation::IncompleteBasicInfoError < StudentsActivation::StudentActivationError
  def message_key
    'student.activation_errors.incomplete_basic_info'
  end
end
