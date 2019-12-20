module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, class_name: 'Comment', as: :commentable, dependant: :destroy
  end

  class_methods do
    def commentable(*attributes)
      attributes = [attributes] unless attributes.is_a?(Array)

      attributes.each do |attribute|
        class_eval "has_many :#{attribute}_comments, class_name: 'Comment', source: :commentable, source_type: '#{attribute.to_s.classify}, foreign_key: :owner_id'"
      end
    end

    def commenter(*attributes)
      attributes = [attributes] unless attributes.is_a?(Array)

      attributes.each do |attribute|
        class_eval "has_many :#{attribute}_comments, class_name: '#{attribute.to_s.classify}, source: :owner"
      end
    end

  end

end