FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    number_of_portions { 1 }
    weight_per_portion { 1.5 }
    user { nil }
    family { nil }
  end
end
