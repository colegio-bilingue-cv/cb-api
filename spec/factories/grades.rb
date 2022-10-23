FactoryBot.define do
  factory :grade do
    cicle
    name { Faker::Movies::LordOfTheRings.character }
  end
end
