FactoryBot.define do
  factory :student do
    ci { Faker::Lorem.characters(number: 8) }
    name { Faker::Movies::LordOfTheRings.character }
    surname { Faker::Name.last_name }
    schedule_start { Faker::Lorem.word }
    schedule_end { Faker::Lorem.word }
    birthplace { Faker::Address.full_address }
    birthdate { Date.today }
    nationality { Faker::Address.country }
    first_language { Faker::Lorem.sentence }
    office { Faker::Lorem.word }
    address { Faker::Address.street_address }
    neighborhood { Faker::Address.community }
    medical_assurance { Faker::Company.name }
    emergency { Faker::Company.name }
    phone_number { Faker::Lorem.word }
    vaccine_name { Faker::Name.name }
    vaccine_expiration { Date.today }
    inscription_date { Date.today }
    starting_date { Date.today }
    contact { Faker::Name.name }
    contact_phone { Faker::Lorem.word }

    trait :with_group do
      group
    end

    trait :with_family_member do
      family_members { FactoryBot.create_list(:family_member, 1) }
    end

    trait :with_type_scholarship do
      type_scholarships { FactoryBot.create_list(:type_scholarship, 1, :agreement) }
    end

    trait :with_type_scholarship_without_description do
      type_scholarships { FactoryBot.create_list(:type_scholarship, 1, :special) }
    end

    trait :with_type_scholarship_with_description do
      type_scholarships { FactoryBot.create_list(:type_scholarship, 1, :bidding) }
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

    trait :with_answer do
      answers { FactoryBot.create_list(:answer, 1) }
    end

    trait :without_reference_number do
      reference_number { nil }
    end

    trait :with_evaluation do
      final_evaluations { FactoryBot.create_list(:final_evaluation, 1, :with_group, :with_student) }
      intermediate_evaluations { FactoryBot.create_list(:intermediate_evaluation, 1, :with_group, :with_student) }
    end

    trait :with_tuituion_and_reference_number do
      tuition { Faker::Lorem.word }
      reference_number { Faker::Lorem.word }
    end

    trait :with_relevant_event do
      relevant_events { FactoryBot.create_list(:relevant_event, 1) }
    end
  end
end
