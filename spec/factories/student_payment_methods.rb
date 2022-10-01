FactoryBot.define do
  factory :student_payment_method do
    year { Faker::Date.today}

    trait :with_student do
      student { FactoryBot.create_list(:student, 1) }
    end
    
    trait :with_payment_method do
      payment_method { FactoryBot.create_list(:payment_method, 1) }
    end

    trait :with_invalid_data do
      year = nil
    end

  end
end
