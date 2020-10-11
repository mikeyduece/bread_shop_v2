FactoryBot.define do
  factory :family do
    name { Faker::Food.name }
  end
end
