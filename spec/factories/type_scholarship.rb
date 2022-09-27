FactoryBot.define do
  factory :type_scholarship do
    type { Faker::Number.between(from:1, to:4) }
    description { Faker::Lorem.sentence }

    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end

    trait :with_invalid_data do
      description = nil
    end
  end
end
