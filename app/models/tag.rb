class Tag < ApplicationRecord
  has_many :recipe_tags, dependent: :destroy
  has_many :recipes, through: :recipe_tags
  
  validates :name, presence: true, uniqueness: true
  
  before_create :downcase_name!
  
  private
  
  def downcase_name!
    self.name = self.name.downcase!
  end
  
end
