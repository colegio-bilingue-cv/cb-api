FactoryBot.define do
  factory :document do
    document_type { Document::document_types.keys.sample }
    upload_date { Date.today }

    user
  end
end
