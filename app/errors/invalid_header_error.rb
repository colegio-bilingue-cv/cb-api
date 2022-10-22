class InvalidHeaderError < ApiError
  def message_key
    'errors.forbidden.invalid_token'
  end
end
