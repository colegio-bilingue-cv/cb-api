FactoryBot.define do
    factory :family_member do
        ci { Faker::Number.number(digits: 8) }
        role { Faker::Name.name }
        full_name { Faker::Name.name }
        birthplace { Faker::Address.full_address }
        birthdate { Time.now }
        nationality { Faker::Address.country }
        first_language { Faker::Lorem.sentence }
        marital_status { Faker::Lorem.word}
        cellphone { Faker::Number.number(digits: 8) }
        email { Faker::Faker::Internet.email }
        address { Faker::Address.street_address }
        neighborhood { Faker::Address.community }
        education_level { Faker::Lorem.sentence }
        occupation { Faker::Job.title }
        workplace { Faker::Company.name }
        workplace_neighbourhood {Faker::Address.community }
        workplace_phone { Faker::Number.number(digits: 8) }
        created_at { Time.now }
        updated_at { Time.now }
        association :student
    end
end
