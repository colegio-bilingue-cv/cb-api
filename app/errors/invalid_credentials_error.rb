class InvalidCredentialsError < ApiError
  def message_key
    'errors.invalid_credentials'
  end
end
