FactoryBot.define do
  factory :category do
    name { Faker::Music::Rush.album }
  end
end
