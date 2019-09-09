class Comment < ApplicationRecord

  belongs_to :commentable, polymorphic: true
  belongs_to :owner, polymorphic: true
  belongs_to :parent, class_name: 'Comment', optional: true, foreign_key: :parent_id

  has_many :replies, as: :owner, class_name: 'Comment', dependent: :destroy
  has_many :likeable, as: :owner, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, too_short: "Comment must be at least %{count} characters" }
end
