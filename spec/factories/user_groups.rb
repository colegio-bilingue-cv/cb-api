FactoryBot.define do
  factory :user_group do
    trait :teacher do
      role_id { Role.find_by(name: :teacher).id }
    end

    trait :support_teacher do
      role_id { Role.find_by(name: "support_teacher").id }
    end

    trait :with_group do
      group { FactoryBot.create(:group) }
    end

    trait :principal do
      role_id { Role.find_by(name: :principal).id }
    end

    trait :with_group_and_students do
      group { FactoryBot.create(:group, :with_student) }
    end
  end
end
