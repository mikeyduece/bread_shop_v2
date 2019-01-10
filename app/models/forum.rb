class Forum < ApplicationRecord
  belongs_to :user
  
  has_many :comments, as: :owner

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :body, presence: true, length: { minimum: 10, too_short: "Comment must be at least %{count} characters" }
end