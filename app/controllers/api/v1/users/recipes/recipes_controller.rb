module Api
  module V1
    module Users
      module Recipes
        class RecipesController < UsersBaseController
          skip_before_action :set_user
          before_action :set_user_recipe, except: %i[create index]
          
          def create
            require 'pry'; binding.pry
            service = ::Recipes::Create.call(user: current_user, params: recipe_params)
            return error_response(service.errors) unless service.success?
            
            success_response(serialized_recipe(service.recipe), :created)
          end
          
          def index
            recipes = current_user.recipes.includes(:recipe_tags,:tags).limit(limit).offset(offset)
            success_response(serialized_recipe(recipes, meta: { total: recipes.count, per_page: limit, page: offset + 1 }))
          end
          
          def show
            success_response(serialized_recipe(@recipe))
          end
          
          def update
            @recipe.update_recipe(params: recipe_params)
            success_response(serialized_recipe(@recipe))
          end
          
          def destroy
            return error_response(code: 404, message: t('api.errors.recipes.record_not_found')) unless @recipe.present?
            
            recipe_name = @recipe.name
            @recipe.destroy
            
            success_response({ data: { message: t('api.recipes.recipe_deleted', name: recipe_name) } }, :accepted)
          end
          
          def scale
            service = Recipes::ScaleService.call(params: recipe_params)
            return error_response(service.errors) unless service.success?
            
            success_response(serialized_recipe(service.recipe, RecipeSerializer))
          end
          
          private
          
          def serialized_recipe(recipe, options = {})
            serialized_resource(recipe, RecipeSerializer, options.merge!(include: %i[tags]))
          end
          
          def set_user_recipe
            @recipe ||= current_user.recipes.find_by(id: params[:recipe_id] || params[:id])
          end
          
          def recipe_params
            params.permit(
              data: [
                :type,
                attributes: %i[name unit number_of_portions weight_per_portion],
                relationships: [
                  ingredients: [data: [:type, attributes: %i[name amount]]],
                  tags: [data: [:type, attributes: %i[name]]]
                ]
              ]
            ).to_h.deep_symbolize_keys
          end
        end
      end
    end
  end
end