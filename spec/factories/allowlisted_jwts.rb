FactoryBot.define do
  factory :allowlisted_jwt do
    jti { SecureRandom.uuid }
    exp { DateTime.now }
  end
end
