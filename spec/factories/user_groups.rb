FactoryBot.define do
  factory :user_group do    
    trait :teacher do
      role_id { 2 }
    end
  end
end
