FactoryBot.define do
  factory :student_type_scholarship do

    trait :with_student do
      student
    end

    trait :with_type_scholarship do
      type_scholarship
    end

    trait :with_invalid_data do
      date = nil
    end

  end
end
