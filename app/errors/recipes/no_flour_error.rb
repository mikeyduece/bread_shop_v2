class Recipes::NoFlourError < ::Base
  
  def code
    404
  end
  
  def message
    I18n.t('api.errors.recipes.no_flour')
  end
  
end