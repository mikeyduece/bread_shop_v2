FactoryBot.define do
  factory :ingredient do
    association :category, factory: :category
    
    sequence :name do |n|
      "#{n}Ingredient"
    end
  end
end
