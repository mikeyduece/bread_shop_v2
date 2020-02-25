FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(6) }
    first_name { Faker::Name::first_name }
    last_name { Faker::Name::last_name }

    factory :user_with_recipes do
      after(:create) do |user|
        create_list(:recipe, 4, user: user)
      end
    end
    
  end
end
