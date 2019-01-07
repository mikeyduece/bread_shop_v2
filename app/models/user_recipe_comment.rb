class UserRecipeComment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  belongs_to :comment
end
