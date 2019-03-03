FactoryBot.define do
  factory :idea do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    user
  end
end
