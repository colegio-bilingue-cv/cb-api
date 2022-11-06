FactoryBot.define do
  factory :group do
    grade
    name { Faker::Movies::LordOfTheRings.character }
    year { Faker::Number.number(digits: 4) }

    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end
  end
end
