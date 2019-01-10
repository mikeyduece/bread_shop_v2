class Forum < ApplicationRecord
  belongs_to :user
  
  has_many :user_forum_comments, dependent: :destroy
  has_many :comments, as: :owner

  validates :title, :body, presence: true
  validates :body, length: { minimum: 10, too_short: "Comment must be at least %{count} characters" }
end