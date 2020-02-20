module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, class_name: 'Like', as: :likeable, dependent: :destroy
    has_many :likeable_objects, class_name: 'Like', as: :liker, dependent: :destroy
  end

  class_methods do
    def likeable(*attributes)
      raise NotImplementedError unless self.respond_to?(:likeable)
      
      attributes = [attributes] unless attributes.is_a?(Array)

      attributes.each do |attribute|
        class_eval "has_many :by_liking_#{attribute}, -> { order(created_at: :desc) }, class_name: 'Like', source: :liker, source_type: '#{attribute.to_s.classify}', foreign_key: :liker_id, dependent: :destroy"
        class_eval "has_many :liked_#{attribute}, through: :by_liking_#{attribute}, source: :likeable, source_type: '#{attribute.to_s.classify}'"
      end
    end

    def liker(*attributes)
      raise NotImplementedError unless self.respond_to?(:liker)
      
      attributes = [attributes] unless attributes.is_a?(Array)
      attributes.each do |attribute|
        class_eval "has_many :by_liked_#{attribute}, -> { order(created_at: :desc) }, class_name: 'Like', source: :likeable, source_type: '#{attribute.to_s.classify}', foreign_key: :likeable_id, dependent: :destroy"
        class_eval "has_many :liked_by_#{attribute}, through: :by_liked_#{attribute}, source: :liker, source_type: '#{attribute.to_s.classify}'"
      end
    end
  end
end