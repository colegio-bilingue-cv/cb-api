class ApiError < StandardError
  def message_key
    raise 'You should create an error subclass and override this method'
  end
end
