FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    student
  end
end
