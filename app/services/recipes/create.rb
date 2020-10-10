module Recipes
  class Create < BaseRecipeService
    
    def call
      build_recipe!
      
      Success.new(recipe: recipe)
    rescue ActiveRecord::RecordNotUnique => e
      Failure.new(errors: I18n.t('api.errors.recipes.record_exists'))
    rescue StandardError => e
      Failure.new(errors: e.message)
    end
    
    private
    
    attr_accessor :recipe
    
    def build_recipe!
      attrs = attributes(params)
      raise ActiveRecord::RecordNotUnique, I18n.t('api.errors.recipes.record_exists') if user.recipes.find_by(name: attrs[:name])
      
      @recipe ||= user.recipes.build(attrs)
      
      add_ingredients!
      tag_ids = add_tags!
      @recipe.tag_ids = tag_ids
      @recipe.save!
    end
    
    def add_ingredients!
      attrs = relationship(params, :ingredients)
      ingredient_attrs = build_recipe_ingredients(ingredients: attrs)
      @recipe.assign_attributes(ingredient_attrs)
    end
    
    def add_tags!
      tags = relationship(params, :tags)
      return unless tags
      
      tags.map { |tag_hash| Tag.find_or_create_by(attributes(tag_hash)).id }
    end
  
  end
end