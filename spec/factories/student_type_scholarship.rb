FactoryBot.define do
  factory :student_type_scholarship do
    
    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end

    trait :with_type_scholarship do
      type_scholarships { FactoryBot.create_list(:type_scholarship, 1) }
    end

    trait :with_invalid_data do
    end
  end
end
