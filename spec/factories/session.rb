FactoryBot.define do
  factory :session do
    active { true }
    device_platform { :browser }
    expires_at { 8.hours.from_now }
    ip_address { "127.0.0.1" }
    location { nil }
    token { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDY0MzkyOTF9.cwxq_eXQBxkS706pUPIdIrGLSSYHt5tzMgmVNHI23tU" }
    user_agent { "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:64.0) Gecko/20100101 Firefox/64.0" }
    uid { nil }
    user
  end
end
