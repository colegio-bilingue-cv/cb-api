FactoryBot.define do
  factory :document do
    document_type { Faker::Lorem.sentences }
    upload_date { Date.today }

    user
  end
end
