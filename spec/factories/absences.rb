FactoryBot.define do
  factory :absence do
    start_date { Date.today }
    end_date { Date.today }
    reason { Faker::Lorem.paragraph }
    user
  end
end
