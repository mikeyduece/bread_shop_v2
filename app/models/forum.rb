class Forum < ApplicationRecord
  liker :user

  belongs_to :user
  
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :body, presence: true, length: { minimum: 10, too_short: "Comment must be at least %{count} characters" }
end