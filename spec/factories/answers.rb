FactoryBot.define do
  factory :answer do
    answer { Faker::Movies::LordOfTheRings.character }
    student
    question
  end
end
