FactoryBot.define do
  factory :payment_method do
    # method is a useed name on Factorybot so it needs to be set manually on model creation

    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end

  end
end
