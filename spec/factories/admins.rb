FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    forums { nil }
  end
end
