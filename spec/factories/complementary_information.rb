FactoryBot.define do
  factory :complementary_information do
    date { Date.today }
    description { Faker::Lorem.sentences }

    user
  end
end
