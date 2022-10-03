FactoryBot.define do
  factory :user do
    ci { Faker::Number.number(digits: 8) }
    name { Faker::Movies::LordOfTheRings.character }
    surname { Faker::Name.last_name }
    birthdate { Date.today }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }

    trait :with_invalid_data do
      ci { Faker::Number.number(digits: 3) }
      name = nil
    end

    after(:create) { |user| user.add_role(:teacher) }
  end
end
