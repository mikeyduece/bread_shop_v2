class Comment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :recipe
  belongs_to :parent, class_name: 'Comment'

  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
end
