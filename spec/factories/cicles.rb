FactoryBot.define do
  factory :user do
    name { Faker::Movies::LordOfTheRings.character }
  end
end
