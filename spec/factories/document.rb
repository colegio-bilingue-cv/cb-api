FactoryBot.define do
  factory :document do
    document_type { 0 }
    upload_date { Date.today }

    user
  end
end
