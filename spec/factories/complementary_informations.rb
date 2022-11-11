FactoryBot.define do
  factory :complementary_information do
    date { Date.today }
    description { Faker::GreekPhilosophers.quote }

    user
  end
end
