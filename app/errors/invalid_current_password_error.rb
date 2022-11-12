class InvalidCurrentPasswordError < ApiError
  def message_key
    'user.invalid_current_password'
  end
end
