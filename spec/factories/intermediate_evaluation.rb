FactoryBot.define do
  factory :intermediate_evaluation do
    starting_month { Date.current }
    ending_month  { Date.current.next_month }

    trait :with_student do
      student
    end

    trait :with_group do
      group { FactoryBot.create_list(:group, 1) }
    end

    trait :with_invalid_data do
      starting_month = nil
      ending_month = nil
    end

  end
end
