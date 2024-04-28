# frozen_string_literal: true

class AbstractModel
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  before_create :set_created
  before_save :set_updated

  def self.token_prop(prefix)
    define_method(:_id) do
      super() ? "#{prefix}#{super()}" : nil
    end
  end

  private def set_created
    self.created = Time.now.utc if new_record?
  end

  private def set_updated
    self.updated = Time.now.utc
  end
end
