# frozen_string_literal: true

module Recipes
  class ScaleService < Recipes::BaseRecipeService
    def call
      Success.new(scaled_recipe: scale!, scaled_dough_weight: new_total_dough_weight)
    rescue StandardError => e
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace)
      Failure.new(errors: e.message)
    end

    attr_reader :new_total_dough_weight

    private def scale!
      new_number_of_portions = recipe_field_values(:number_of_portions)
      new_weight_per_portion = recipe_field_values(:weight_per_portion)
      @new_total_dough_weight = new_number_of_portions * new_weight_per_portion
      new_flour_weight = recipe.new_flour_weight(@new_total_dough_weight)
      new_totals = recipe.new_totals(new_flour_weight)

      new_totals.merge!({ number_of_portions: new_number_of_portions, weight_per_portion: new_weight_per_portion })
    end

    private def recipe_field_values(attribute)
      # Will dig out the attribute from the params, if it is not there it will use the attribute value from the recipe
      # In this example, this would be Recipe#number_of_portions and Recipe#weight_per_portion
      attribute(params, attribute) || recipe.send(attribute)
    end
  end
end
