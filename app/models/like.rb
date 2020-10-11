class Like < ApplicationRecord
  belongs_to :owner, polymorphic: true
end