module SessionManagment
  def generate_token(user)
    JWT::Token.generate_for(user.id)
  end
end

RSpec.configure do |config|

  config.include SessionManagment

end
