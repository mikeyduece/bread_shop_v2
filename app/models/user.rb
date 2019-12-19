class User < ApplicationRecord
  include Likeable

  likeable :recipes, :forums
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
    foreign_key: :resource_owner_id,
    dependent: :delete_all # or :destroy if you need callbacks

  has_many :recipes
  has_many :forums
  # comments
  has_many :recipe_comments, through: :recipes, class_name: 'Comment', source: :comments
  has_many :forum_comments, through: :forums, class_name: 'Comment', source: :forum

  # likes
end
