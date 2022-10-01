FactoryBot.define do
  factory :payment_method do
    
    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end

    trait :with_invalid_data do
      method = nil
    end
  end
end
