class User < ApplicationRecord
  include DoorkeeperHelper
  include Likeable
  include Commentable

  likeable :recipes, :forums, :comments
  commentable :recipes, :forums, :comments

  has_many :recipes
  has_many :forums

end
