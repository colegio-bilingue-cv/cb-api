FactoryBot.define do
  factory :question do
    category
    cicle { FactoryBot.create(:cicle) }

    text { Faker::Lorem.paragraph }
  end
end
