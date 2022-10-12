FactoryBot.define do
  factory :type_scholarship do
    scholarship { Faker::Number.between(from: 0, to: 3) }
    description { if scholarship==(0||2) then Faker::Lorem.sentence else nil end}

    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end
  end
end
