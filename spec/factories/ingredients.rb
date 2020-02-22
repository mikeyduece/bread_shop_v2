FactoryBot.define do
  factory :ingredient do
    category
    
    sequence :name do |n|
      "#{n} flour"
    end
  end
end
