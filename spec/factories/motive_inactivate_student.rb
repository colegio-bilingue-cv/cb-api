FactoryBot.define do
  factory :motive_inactivate_student do
    last_day { Date.current }
    motive  { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    student { FactoryBot.create(:student, :inactive) }
  end
end
