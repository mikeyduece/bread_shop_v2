class Forum < ApplicationRecord
  belongs_to :admin
  
  has_many :forum_topics, inverse_of: :forum
  
  validates :title, presence: true, uniqueness: { scope: :admin_id }
end