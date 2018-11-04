FactoryBot.define do
  factory :idea do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    published_at { Faker::Date.between(2.days.ago, Date.today) }
    user
  end
end
