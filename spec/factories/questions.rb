FactoryBot.define do
  factory :question do
    category
    cicles { FactoryBot.create_list(:cicle, 1) }

    text { Faker::Lorem.paragraph }
  end
end
