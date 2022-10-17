FactoryBot.define do
  factory :type_scholarship do
      trait :bidding do
        scholarship { :bidding }
        description { Faker::Lorem.sentence }
      end
      trait :subsidized do
        scholarship { :subsidized }
        description { nil }
      end
      trait :agreement do
        scholarship { :agreement }
        description { Faker::Lorem.sentence }
      end
      trait :special do
        scholarship { :special }
        description { nil }
      end

    trait :with_student do
      students { FactoryBot.create_list(:student, 1) }
    end
  end
end
