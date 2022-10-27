FactoryBot.define do
  factory :final_evaluation do

    traits_for_enum :status, %w[pending failed passed]

    trait :with_student do
      student
    end

    trait :with_group do
      group { FactoryBot.create_list(:group, 1) }
    end

    trait :with_invalid_data do
      status = nil
    end

  end
end
