FactoryBot.define do
  factory :student_type_scholarship do
    date { Date.today }
    
    trait :with_student do
      student { FactoryBot.create(:student) }
    end

    trait :with_type_scholarship do
      type_scholarship { FactoryBot.create(:type_scholarship) }
    end

    trait :with_invalid_data do
      date = nil
    end
  end
end
