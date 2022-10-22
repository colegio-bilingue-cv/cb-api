FactoryBot.define do
  factory :question do
    category

    text { Faker::Lorem.paragraph }
  end
end
