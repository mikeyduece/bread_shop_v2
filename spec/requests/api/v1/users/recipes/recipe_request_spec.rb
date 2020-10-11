require 'rails_helper'

RSpec.describe 'User Recipes API' do
  include_context 'shared recipe params'
  include_context 'shared headers'
  
  let(:user) { create(:user_with_recipes) }
  let(:params) { lean_create_params }
  
  before do
    login_as_user(user)
  end
  
  context 'user recipes' do
    it { expect { get '/api/v1/users/recipes' }.to raise_error(ActionController::RoutingError) }
    
    it 'returns list of recipes for a user with params' do
      get "/api/v1/users/recipes", headers: headers
      expect(response).to be_successful
      
      recipes = json_response
      expect(response).to have_http_status(:ok)
      expect(recipes[:data].count).to eq(4)
    end
    
    it 'returns recipe with ingredients and total percentage' do
      recipe = user.recipes[0]
      %w[bread awesome].each do |tag_name|
        recipe.tags << create(:tag, name: tag_name)
      end
      
      recipe.recipe_ingredients.clear
      flour = create(:ingredient, name: 'flour')
      recipe.recipe_ingredients << create(:recipe_ingredient, ingredient_id: flour.id)
      6.times do
        create(:recipe_ingredient, recipe: recipe)
      end
      
      get "/api/v1/users/recipes/#{recipe.id}", headers: headers
      
      expect(response).to be_successful
      
      json_recipe = json_response
      
      expect(response.status).to eq(200)
      expect(attributes(:name)).to eq(recipe.name)
      expect(json_recipe[:data][:id]).to eq(recipe.id.to_s)
      expect(attributes(:formatted_ingredients).length).to eq(7)
    end
    
    it 'can create recipe' do
      # VCR.use_cassette('new_recipes') do
      recipe = create(:recipe, user: user, name: 'baguette')
      Recipes::Create.any_instance.stub(:call).and_return(double('Success', success?: true, recipe: recipe))

      post "/api/v1/users/recipes", params: params, headers: headers
      expect(response).to be_successful
      
      new_recipe = json_response
      expect(response).to have_http_status(:created)
      expect(new_recipe[:data][:id]).to eq(user.recipes.last.id.to_s)
      expect(attributes(:name)).to eq(user.recipes.last.name)
      expect(user.recipes.exists?(name: 'baguette')).to be(true)
      # end
    end
    
    it 'cannot create a recipe with same name as one that already exists' do
      # VCR.use_cassette('dupe_recipes') do
      user.recipes.clear
      user.recipes << create(:recipe, name: 'baguette')
      errors = 'You already have a recipe with that name'
      allow(Recipes::Create).to receive(:call).with(user: user, params: params).and_return(double('Success', success?: false, errors: errors))

      post "/api/v1/users/recipes", params: params, headers: headers
      
      expect(response).not_to be_successful
      
      result = json_response
      expect(response).to have_http_status(:unprocessable_entity)
      expect(result[:errors].first[:detail]).to eq('You already have a recipe with that name')
      # end
    end
    
    it 'can assign a tag to a recipe' do
      # VCR.use_cassette('tags') do
      tag_names = %w[Lean Baguette French\ Bread]
      tag_params = tag_names.each_with_object([]) { |tag, acc| acc << { data: { type: :tag, attributes: { name: tag } } } }
      params[:data][:relationships].merge!(tags: tag_params)
      
      post "/api/v1/users/recipes", params: params, headers: headers
      
      expect(response).to be_successful
      
      tags = included(:tag)
      
      expect(tags.all? { |tag| tag_names.include?(tag.dig(:attributes, :name)) }).to be(true)
      expect(user.recipes.find(json_response[:data][:id]).tags.pluck(:name) == tag_names).to be(true)
      # end
    end
    
    it 'user can delete recipe' do
      # VCR.use_cassette('formatting') do
      recipe = user.recipes[0]
      flour = create(:ingredient, name: 'Flour')
      recipe.recipe_ingredients << create(:recipe_ingredient, ingredient_id: flour.id)
      
      delete "/api/v1/users/recipes/#{recipe.id}", headers: headers
      
      expect(response).to be_successful
      deleted = json_response
      
      expect(response).to have_http_status(:accepted)
      expect(deleted.dig(:data, :message)).to eq("You have successfully deleted your #{recipe.name} recipe")
      expect(Recipe.all).not_to include(recipe.id)
      # end
    end
  
  end
end
