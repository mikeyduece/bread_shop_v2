FactoryBot.define do
  factory :ingredient do
    category { Category.find_or_create_by(name: :flour) }
    
    sequence :name do |n|
      "#{n} flour"
    end
    
  end
end
