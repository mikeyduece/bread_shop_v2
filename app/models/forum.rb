class Forum < ApplicationRecord
  belongs_to :admin
  
  validates :title, presence: true, uniqueness: { scope: :admin_id }
end