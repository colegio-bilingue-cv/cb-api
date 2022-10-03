FactoryBot.define do
  factory :student_payment_method do
    year { Date.today }

    trait :with_student do
      student
    end

    trait :with_payment_method do
      payment_method
    end

    trait :with_invalid_data do
      year = nil
    end

  end
end
