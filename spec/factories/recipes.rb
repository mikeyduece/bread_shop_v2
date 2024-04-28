# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    sequence :name do |n|
      "#{n}Recipe"
    end
    number_of_portions { 2 }
    weight_per_portion { 13.28 }
    user

    transient do
      ingredient_count { 6 }
    end

    before(:create) do |recipe|
      %i[flour water salt yeast].map do |name|
        ingredient = create(:ingredient, name: "#{SecureRandom.uuid} #{name}")
        bp = 100.0 if name.eql?(:flour)
        create(:recipe_ingredient, recipe: recipe, ingredient: ingredient, bakers_percentage: bp)
      end
    end
    family { Family.all.sample || association(:family) }
  end
end
