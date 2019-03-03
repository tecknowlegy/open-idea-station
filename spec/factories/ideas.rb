FactoryBot.define do
  factory :idea do
    name { Faker::Name.name }
    slug_name { name.downcase.parameterize }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    user
  end
end
