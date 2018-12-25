FactoryBot.define do
  factory :recipe_ingredient do
    recipe { nil }
    ingredient { nil }
    amount { 1.5 }
  end
end
