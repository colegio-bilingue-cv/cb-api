FactoryBot.define do
  factory :student_type_scholarship do
    
    trait :with_student do
      student { FactoryBot.create(:student) }
    end

    trait :with_type_scholarship do
      type_scholarship { FactoryBot.create(:type_scholarship) }
    end

    trait :with_invalid_data do
    end
  end
end
