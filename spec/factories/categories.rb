FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "#{n} flour"
    end
  end
end
