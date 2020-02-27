FactoryBot.define do
  factory :forum do
    admin
    title { Faker::Movie.unique.quote }
  end
end
