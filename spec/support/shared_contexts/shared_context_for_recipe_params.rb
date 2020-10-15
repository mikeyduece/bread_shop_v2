RSpec.shared_context 'shared recipe params' do
  let(:lean_create_params) do
    {
      data: {
        type: 'recipe',
        attributes: { name: 'baguette', number_of_portions: 2.to_s, weight_per_portion: 13.to_s },
        relationships: {
          ingredients: [
            { data: { type: 'ingredient', attributes: { name: 'flour', amount: 16.0.to_s } } },
            { data: { type: 'ingredient', attributes: { name: 'water', amount: 10.24.to_s } } },
            { data: { type: 'ingredient', attributes: { name: 'yeast', amount: 0.32.to_s } } },
            { data: { type: 'ingredient', attributes: { name: 'salt', amount: 0.32.to_s } } }
          ]
        }
      }
    }
  end
  
  let(:lean_bagel_params) do
    {
      data: {
        type: 'recipe',
        attributes: { name: 'bagels', number_of_portions: 12, weight_per_portion: 4 },
        relationships: {
          ingredients: [
            { data: { type: 'ingredient', attributes: { name: 'bread flour', amount: 32 } } },
            { data: { type: 'ingredient', attributes: { name: 'water', amount: 18.56 } } },
            { data: { type: 'ingredient', attributes: { name: 'sugar', amount: 0.75 } } },
            { data: { type: 'ingredient', attributes: { name: 'canola oil', amount: 0.5 } } },
            { data: { type: 'ingredient', attributes: { name: 'molasses', amount: 0.5 } } },
            { data: { type: 'ingredient', attributes: { name: 'yeast', amount: 0.32 } } },
            { data: { type: 'ingredient', attributes: { name: 'salt', amount: 0.66 } } }
          ]
        }
      }
    }
  end
  
  let(:lean_italian_torpedo_params) do
    {
      data: {
        type: 'recipe',
        attributes: { name: 'italian torpedo rolls', number_of_portions: 9, weight_per_portion: 6 },
        relationships: {
          ingredients: [
            { data: { type: 'ingredient', attributes: { name: 'flour', amount: 21.5 } } },
            { data: { type: 'ingredient', attributes: { name: 'semolina', amount: 10.0 } } },
            { data: { type: 'ingredient', attributes: { name: 'honey', amount: 0.23 } } },
            { data: { type: 'ingredient', attributes: { name: 'olive oil', amount: 1.5 } } },
            { data: { type: 'ingredient', attributes: { name: 'water', amount: 19.5 } } },
            { data: { type: 'ingredient', attributes: { name: 'yeast', amount: 0.5 } } },
            { data: { type: 'ingredient', attributes: { name: 'salt', amount: 0.75 } } }
          ]
        }
      }
    }
  end
  
  let(:soft_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'ballons', number_of_portions: 24, weight_per_portion: 2 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour', amount: 28.0 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 11.2 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.56 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.67 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 5.6 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 1.88 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 1.4 } } }
          ]
        }
      }
    }
  end
  
  let(:soft_challah_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'Challah', number_of_portions: 2, weight_per_portion: 20 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour', amount: 22.0 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 6.0 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.5 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.33 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 3.0 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 3.0 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 1.5 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.5 } } },
            { data: { type: :ingredient, attributes: { name: 'eggs', amount: 5.25 } } },
            { data: { type: :ingredient, attributes: { name: 'honey', amount: 0.35 } } }
          ]
        }
      }
    }
  end
  
  let(:soft_pizza_dough_params) do
    {
      data: {
        type: 'recipe',
        attributes: { name: 'Pizza Dough', number_of_portions: 3, weight_per_portion: 9.5 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour', amount: 16.0 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.32 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 11.2 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.24 } } },
            { data: { type: :ingredient, attributes: { name: 'honey', amount: 0.5 } } },
            { data: { type: :ingredient, attributes: { name: 'olive oil', amount: 1.0 } } }
          ]
        }
      }
    }
  end
  
  let(:rich_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'butter bread', number_of_portions: 6, weight_per_portion: 6 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'bread flour', amount: 21.0 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 13.0 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 1 } } },
            { data: { type: :ingredient, attributes: { name: 'eggs', amount: 1.05 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.4 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 4.5 } } }
          ]
        }
      }
    }
  end
  
  let(:rich_brioche_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'brioche', number_of_portions: 2, weight_per_portion: 20 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour i', amount: 6.0 } } },
            { data: { type: :ingredient, attributes: { name: 'flour ii', amount: 18.0 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 6.0 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 1.0 } } },
            { data: { type: :ingredient, attributes: { name: 'eggs', amount: 7.0 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 2.0 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.66 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 7.0 } } },
          ]
        }
      }
    }
  end
  
  let(:slack_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'foccacia', number_of_portions: 1, weight_per_portion: 48 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'flour I', amount: 11.0 } } },
            { data: { type: :ingredient, attributes: { name: 'flour II', amount: 16.0 } } },
            { data: { type: :ingredient, attributes: { name: 'water', amount: 19.0 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.58 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 0.72 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 1.68 } } },
            { data: { type: :ingredient, attributes: { name: 'olive oil', amount: 1.44 } } }
          ]
        }
      }
    }
  end
  
  let(:sweet_create_params) do
    {
      data: {
        type: :recipe,
        attributes: { name: 'cinnamon rolls', number_of_portions: 12, weight_per_portion: 3.75 },
        relationships: {
          ingredients: [
            { data: { type: :ingredient, attributes: { name: 'bread flour', amount: 8.0 } } },
            { data: { type: :ingredient, attributes: { name: 'pastry flour', amount: 13.0 } } },
            { data: { type: :ingredient, attributes: { name: 'eggs', amount: 4.0 } } },
            { data: { type: :ingredient, attributes: { name: 'salt', amount: 0.47 } } },
            { data: { type: :ingredient, attributes: { name: 'yeast', amount: 1.26 } } },
            { data: { type: :ingredient, attributes: { name: 'milk', amount: 8.19 } } },
            { data: { type: :ingredient, attributes: { name: 'sugar', amount: 4.00 } } },
            { data: { type: :ingredient, attributes: { name: 'butter', amount: 5.88 } } },
            { data: { type: :ingredient, attributes: { name: 'vanilla extract', amount: 0.66 } } },
          ]
        }
      }
    }
  end

end
