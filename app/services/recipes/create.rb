# frozen_string_literal: true

module Recipes
  class Create < BaseRecipeService
    def call
      build_recipe!

      Success.new(recipe:)
    rescue ActiveRecord::RecordNotUnique
      Failure.new(errors: I18n.t('api.errors.recipes.record_exists'))
    rescue StandardError => e
      Failure.new(errors: e.message)
    end

    attr_accessor :recipe

    private def build_recipe!
      attrs = attributes(params)
      if user.recipes.exists?(name: attrs[:name])
        raise ActiveRecord::RecordNotUnique,
              I18n.t('api.errors.recipes.record_exists')
      end

      @recipe ||= user.recipes.build(attrs)

      add_ingredients!
      tag_ids = add_tags!
      @recipe.tag_ids = tag_ids
      @recipe.save!
    end

    private def add_ingredients!
      attrs = relationship(params, :ingredients)
      ingredient_attrs = build_recipe_ingredients(ingredients: attrs)
      @recipe.assign_attributes(ingredient_attrs)
    end

    private def add_tags!
      tags = relationship(params, :tags)
      return unless tags

      tags.map { |tag_hash| Tag.find_or_create_by(attributes(tag_hash)).id }
    end
  end
end
