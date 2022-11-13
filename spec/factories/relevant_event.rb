FactoryBot.define do
  factory :relevant_event do
    date { Date.today }
    title { Faker::Job.title }
    description { Faker::Lorem.paragraph }

    user
    student

    traits_for_enum :event_type, %w[event family_situation school_situation extern_report]
  end
end
