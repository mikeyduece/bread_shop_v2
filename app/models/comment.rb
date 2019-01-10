class Comment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :owner, polymorphic: true
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :replies, as: :owner, class_name: 'Comment', dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, too_short: "Comment must be at least %{count} characters" }
end
