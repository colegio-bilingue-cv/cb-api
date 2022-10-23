FactoryBot.define do
  factory :group do
    grade
    name { Faker::Movies::LordOfTheRings.character }
    year { Faker::Number.number(digits: 4) }
  end
end
