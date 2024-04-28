# frozen_string_literal: true

# Abstract Model that all models need to inherit from
class AbstractModel
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  before_create :set_created
  before_save :set_updated

  private_class_method def self.token_prop(prefix)
    define_method(:_id) do
      super() ? "#{prefix}#{super()}" : nil
    end
  end

  private_class_method def self.db_namespace(database_name = 'mongo')
    store_in database: database_name
  end

  private_class_method def self.collection(collection_name)
    store_in collection: collection_name
  end

  private def set_created
    self.created = Time.now.utc if new_record?
  end

  private def set_updated
    self.updated = Time.now.utc
  end
end
