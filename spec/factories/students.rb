FactoryBot.define do
  factory :student do
    ci { Faker::Number.number(digits: 8) }
    name { Faker::Movies::LordOfTheRings.character }
    surname { Faker::Name.last_name }
    schedule_start { Faker::Lorem.word }
    schedule_end { Faker::Lorem.word }
    tuition { Faker::Number.number(digits: 8) }
    reference_number { Faker::Number.number(digits: 8) }
    birthplace { Faker::Address.full_address }
    birthdate { Date.today }
    nationality { Faker::Address.country }
    first_language { Faker::Lorem.sentence }
    office { Faker::Lorem.word }
    address { Faker::Address.street_address }
    neighborhood { Faker::Address.community }
    medical_assurance { Faker::Company.name }
    emergency { Faker::Company.name }
    phone_number { Faker::Number.number(digits: 8) }
    vaccine_name { Faker::Name.name }
    vaccine_expiration { Date.today }
    inscription_date { Date.today }
    starting_date { Date.today }
    contact { Faker::Name.name }
    contact_phone { Faker::Number.number(digits: 8) }
    email { Faker::Internet.email }

    trait :with_family_member do
      family_members { FactoryBot.create_list(:family_member, 1) }
    end

    trait :with_type_scholarship do
      type_scholarships { FactoryBot.create_list(:type_scholarship, 1) }
    end

    trait :with_invalid_data do
      ci { Faker::Number.number(digits: 3) }
      name = nil
    end

    trait :with_comment do
      comments { FactoryBot.create_list(:comment, 1) }
    end

    trait :with_discount do
      discounts { FactoryBot.create_list(:discount, 1) }
    end
  end
end
