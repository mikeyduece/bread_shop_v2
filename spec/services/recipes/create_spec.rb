require 'rails_helper'

RSpec.describe Recipes::Create, type: :service do
  include_context 'shared recipe params'
  let(:user) { create(:user) }
  
  context 'correctly assigns family' do
    context :lean do
      it 'assigns lean for baguette recipe' do
        include 'shared recipe examples'
        service = Recipes::Create.call(user: user, params: lean_create_params)
        expect(service.recipe.family_name).to eq('lean')
        expect(service.recipe.name).to eq('baguette')
      end
      
      it 'assigns lean for bagels' do
        include 'shared recipe examples'
        service = Recipes::Create.call(user: user, params: lean_bagel_params)
        expect(service.recipe.family_name).to eq('lean')
        expect(service.recipe.name).to eq('bagels')
      end
      
      it 'assigns lean for torpedo rolls' do
        include 'shared recipe examples'
        service = Recipes::Create.call(user: user, params: lean_italian_torpedo_params)
        expect(service.recipe.family_name).to eq('lean')
        expect(service.recipe.name).to eq('italian torpedo rolls')
      end
    end
    
    context :soft do
      it 'assigns soft to ballons' do
        include 'shared recipe examples'
        service ||= Recipes::Create.call(user: user, params: soft_create_params)
        expect(service.recipe.family_name).to eq('soft')
        expect(service.recipe.name).to eq('ballons')
      end

      it 'assigns soft to challah' do
        include 'shared recipe examples'
        service ||= Recipes::Create.call(user: user, params: soft_challah_params)
        expect(service.recipe.family_name).to eq('soft')
        expect(service.recipe.name).to eq('challah')
      end
      
      it 'assigns soft to pizza dough' do
        include 'shared recipe examples'
        service ||= Recipes::Create.call(user: user, params: soft_pizza_dough_params)
        expect(service.recipe.family_name).to eq('soft')
        expect(service.recipe.name).to eq('pizza dough')
      end
    end
    
    context :rich do
      it 'assigns rich to butter bread' do
        include 'shared recipe examples'
        service ||= Recipes::Create.call(user: user, params: rich_create_params)
        expect(service.recipe.family_name).to eq('rich')
        expect(service.recipe.name).to eq('butter bread')
      end
      
      it 'assigns rich to brioche' do
        include 'shared recipe examples'
        service ||= Recipes::Create.call(user: user, params: rich_brioche_params)
        expect(service.recipe.family_name).to eq('rich')
        expect(service.recipe.name).to eq('brioche')
      end
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
    
    it 'can assign params to a recipe' do
      include 'shared_examples'
      tag_names = %w[Lean Baguette French\ Bread]
      tag_params = tag_names.each_with_object([]) { |tag, acc| acc << { data: { type: :tag, attributes: { name: tag } } } }
      lean_create_params[:data][:relationships].merge!(tags: tag_params)
      
      service ||= Recipes::Create.call(user: user, params: lean_create_params)

      expect(service.recipe.tags).not_to be_empty
      expect(service.recipe.tags.exists?(name: 'lean')).to be(true)
      expect(service.recipe.tags.exists?(name: 'baguette')).to be(true)
      expect(service.recipe.tags.exists?(name: 'french bread')).to be(true)
    end
  
  end
end
