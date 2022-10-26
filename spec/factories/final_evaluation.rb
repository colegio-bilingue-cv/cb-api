FactoryBot.define do
  factory :final_evaluation do

    trait :with_student do
      student
    end

    trait :with_group do
      group { FactoryBot.create_list(:group, 1) }
    end

    trait :pending do
      status { :pending }
    end

    trait :passed do
      status { :passed }
    end

    trait :failed do
      status { :failed }
    end

    trait :with_invalid_data do
      status = nil
    end

  end
end
