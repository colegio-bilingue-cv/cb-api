FactoryBot.define do
  factory :user_group do    
    trait :teacher do
      role_id { Role.find_by(name: "teacher").id }
    end
    trait :with_group do
      group { FactoryBot.create(:group) }
    end
  end
end
