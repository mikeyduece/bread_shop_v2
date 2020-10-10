RSpec.shared_context 'shared recipe params' do
  let(:lean_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'baguette', number_of_portions: 3, weight_per_portion: 10 },
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
  
  let(:soft_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'ballons', number_of_portions: 12, weight_per_portion: 3 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour', amount: 1.75 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 0.70 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.035 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.04 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 0.35 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 0.12 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 0.088 } } }
          ]
        }
      }
    }
  end
  
  let(:rich_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'brioche', number_of_portions: 2, weight_per_portion: 16 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour', amount: 1.31 } } },
            { data: { type: :ingredient, attributes: { name: 'eggs', amount: 0.10 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 0.81 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 0.28 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.025 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.06 } } }
          ]
        }
      }
    }
  end
  
  let(:slack_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'foccacia', number_of_portions: 2, weight_per_portion: 16 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour I', amount: 0.67 } } },
            { data: { type: :ingredient, attributes: { name: 'flour II', amount: 1.00 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 1.12 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.04 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.05 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 0.10 } } },
            { data: { type: :ingredient, attributes: { name: 'olive oil', amount: 0.09 } } }
          ]
        }
      }
    }
  end
  
  let(:sweet_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'cinnamon rolls', number_of_portions: 12, weight_per_portion: 5.5 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'bread flour', amount: 0.65 } } },
            { data: { type: :ingredient, attributes: { name: 'cake flour', amount: 0.80 } } },
            { data: { type: :ingredient, attributes: { name: 'eggs', amount: 0.22 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.03 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.12 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 0.63 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 0.30 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 0.30 } } }
          ]
        }
      }
    }
  end

end