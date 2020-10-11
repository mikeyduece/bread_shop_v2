require 'rails_helper'

RSpec.describe Recipes::Create, type: :service do
  include_context 'shared recipe params'
  let(:user) { create(:user) }
  
  context 'correctly assigns family' do
    it :lean do
      include 'shared recipe examples'
      service ||= Recipes::Create.call(user: user, params: lean_create_params)
      recipe = service.recipe
      
      expect(recipe.family_name).to eq('lean')
    end
    
    it :soft do
      include 'shared recipe examples'
      service ||= Recipes::Create.call(user: user, params: soft_create_params)
      expect(service.recipe.family_name).to eq('soft')
    end
    
    it :rich do
      include 'shared recipe examples'
      service ||= Recipes::Create.call(user: user, params: rich_create_params)
      expect(service.recipe.family_name).to eq('rich')
    end
    
    it :slack do
      include 'shared recipe examples'
      service ||= Recipes::Create.call(user: user, params: slack_create_params)
      expect(service.recipe.family_name).to eq('slack')
    end
    
    it :sweet do
      include 'shared recipe examples'
      service ||= Recipes::Create.call(user: user, params: sweet_create_params)
      expect(service.recipe.family_name).to eq('sweet')
    end
  
  end
end
