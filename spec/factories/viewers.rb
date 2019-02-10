FactoryBot.define do
  factory :viewer do
    viewed_at { Time.now }
    viewer_ip { Faker::Lorem.sentence }
    idea
  end
end
