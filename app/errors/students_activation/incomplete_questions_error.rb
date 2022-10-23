class StudentsActivation::IncompleteQuestionsError < StudentsActivation::StudentActivationError
  def message_key
    'student.activation_errors.incomplete_questions_error'
  end
end
