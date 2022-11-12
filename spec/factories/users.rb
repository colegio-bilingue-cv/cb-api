FactoryBot.define do
  factory :user do
    ci { Faker::Number.number(digits: 8) }
    name { Faker::Movies::LordOfTheRings.character }
    surname { Faker::Name.last_name }
    birthdate { Date.today }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    password { 'testing' }
    password_confirmation { password }

    after(:create) { |user| user.add_role(:teacher) }

    trait :principal do
      after(:create) { |user| user.add_role(:principal) }
    end

    trait :support_teacher do
      after(:create) { |user| user.add_role(:support_teacher) }
    end

    trait :support_teacher_with_group do
      after(:create) { |user| user.add_role(:support_teacher) }
      after(:create) { |user| FactoryBot.create(:user_group, :support_teacher, :with_group, user_id: user.id) }
    end

    trait :principal_with_group do
      after(:create) { |user| user.add_role(:principal) }
      after(:create) { |user| FactoryBot.create(:user_group, :with_group, :principal, user_id: user.id) }
    end

    trait :with_invalid_data do
      ci { Faker::Number.number(digits: 3) }
      name = nil
    end

    trait :with_group do
      after(:create){ |user| FactoryBot.create(:user_group, :teacher, :with_group, user_id: user.id) }
    end

    trait :with_complementary_information do
      complementary_informations { FactoryBot.create_list(:complementary_information, 1) }
    end


    trait :with_group_and_students do
      after(:create) { |user| FactoryBot.create(:user_group, :teacher, :with_group_and_students, user_id: user.id) }
    end

    trait :with_document do
      documents { FactoryBot.create_list(:document, 1) }
    end

    trait :with_absence do
      absences { FactoryBot.create_list(:absence, 1) }
    end
  end
end
