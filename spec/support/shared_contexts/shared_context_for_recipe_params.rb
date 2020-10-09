RSpec.shared_context 'shared recipe params' do
  let(:lean_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'baguette' },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour', amount: 1.00 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 0.62 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.02 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.02 } } }
          ]
        }
      }
    }
  end
end