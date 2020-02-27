class Admin < ApplicationRecord
  include DoorkeeperHelper
  
  # forums
  has_many :forums, inverse_of: :admin
  has_many :forum_topics, as: :owner, inverse_of: :owner
end