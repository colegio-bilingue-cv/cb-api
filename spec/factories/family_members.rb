FactoryBot.define do
  factory :family_member do
    ci { Faker::Number.number(digits: 8) }
    role { Faker::Name.name }
    full_name { Faker::Name.name }
    birthplace { Faker::Address.full_address }
    birthdate { Date.today }
    nationality { Faker::Address.country }
    first_language { Faker::Lorem.sentence }
    marital_status { Faker::Lorem.word}
    cellphone { Faker::Number.number(digits: 8) }
    email { Faker::Internet.email }
    address { Faker::Address.street_address }
    neighborhood { Faker::Address.community }
    education_level { Faker::Lorem.sentence }
    occupation { Faker::Job.title }
    workplace { Faker::Company.name }
    workplace_neighbourhood {Faker::Address.community }
    workplace_phone { Faker::Number.number(digits: 8) }

    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end
    
    trait :with_invalid_data do
      ci { Faker::Number.number(digits: 3) }
      full_name = nil
    end
  end
end
