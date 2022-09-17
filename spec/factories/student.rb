FactoryBot.define do
    factory :student do
      ci { Faker::Number.number(digits: 8) }
      surname { Faker::Name.name }
      schedule_start { Faker::Lorem.word }
      schedule_end { Faker::Lorem.word }
      tuition { Faker::Number.number(digits:8) }
      reference_number { Faker::Number.number(digits:8) }
      birthplace { Faker::Address.full_address }
      birthdate { Time.now }
      nationality { Faker::Address.country }
      first_language { Faker::Lorem.sentence }
      office { Faker::Lorem.word }
      address { Faker::Address.street_address }
      neighborhood { Faker::Address.community }
      medical_assurance { Faker::Company.name }
      emergency { Faker::Company.name }
      phone_number { Faker::Number.number(digits: 8) }
      vaccine_name { Faker::Name.name }
      vaccine_expiration { Time.now }
      inscription_date { Time.now }
      starting_date { Time.now }
      contact { Faker::Name.name }
      contact_phone { Faker::Number.number(digits: 8) }
      email { Faker::Faker::Internet.email }
      created_at { Time.now }
      updated_at { Time.now }
      association :family_member
    end
end
