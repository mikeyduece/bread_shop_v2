class Forum < ApplicationRecord
  has_many :user_forum_comments, dependent: :destroy
  has_many :comments, as: :owner
end