class StudentsActivation::IncompleteFamilyMembersError < StudentsActivation::StudentActivationError
  def message_key
    'student.activation_errors.incomplete_family_member'
  end
end
