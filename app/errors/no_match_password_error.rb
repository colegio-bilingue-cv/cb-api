class NoMatchPasswordError < ApiError
  def message_key
    'user.no_match_password'
  end
end
