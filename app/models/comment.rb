class Comment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :recipe, polymorphic: true
  belongs_to :forum, polymorphic: true
  belongs_to :parent, class_name: 'Comment'

  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, too_short: "Comment must be at least %{count} characters" }
end
