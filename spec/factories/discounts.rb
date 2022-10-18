FactoryBot.define do
  factory :discount do
    percentage { Faker::Number.number(digits: 3) }
    explanation { 0 }
    start_date { Date.today }
    end_date { Date.today }
    resolution_description { Faker::Lorem.sentences }
    administrative_type { 0 }
    student
  end
end
