class JWT::Token
  JWT_SECRET = ENV['JWT_SECRET']
  JWT_ALGORITHM = ENV['JWT_ALGORITHM']

  attr_reader :user_id, :jti

  def initialize(token)
    @payload = JWT.decode(token, JWT_SECRET, JWT_ALGORITHM).first.with_indifferent_access
    @user_id = @payload[:sub]
    @jti = @payload[:jti]

  rescue JWT::ExpiredSignature, JWT::DecodeError
    raise InvalidHeaderError
  end

  def self.generate_for(user_id)
    jti = SecureRandom.uuid
    exp = (DateTime.now + 8.hours).to_i

    AllowlistedJwt.create!(jti: jti, exp: Time.at(exp), user_id: user_id)

    JWT.encode({sub: user_id, exp: exp, jti: jti}, JWT_SECRET, JWT_ALGORITHM)
  end

  def validate_token!
    raise InvalidHeaderError unless @user_id.present? && Time.now < Time.at(@payload[:exp].to_i) && AllowlistedJwt.exists?(jti: @payload[:jti], user_id: @user_id)
  end

end
