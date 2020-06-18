class User < ApplicationRecord
  include DoorkeeperHelper
  include Likeable
  include Commentable

  likeable :recipes, :forum_topics, :comments
  commentable :recipes, :forum_topics, :comments

  # recipes
  has_many :recipes
  # forums
  has_many :forum_topics, as: :owner, inverse_of: :owner

end
