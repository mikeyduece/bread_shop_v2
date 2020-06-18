class ForumTopic < ApplicationRecord
  belongs_to :owner, polymorphic: true, inverse_of: :forum_topics
  belongs_to :forum, inverse_of: :forum_topics
  
  has_rich_text :content
  
  validates :title, presence: true, uniqueness: {scope: %i[forum_id owner_id owner_type]}
end
