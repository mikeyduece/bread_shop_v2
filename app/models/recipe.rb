class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :family, optional: true

end
