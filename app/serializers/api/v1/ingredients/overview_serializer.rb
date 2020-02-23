class Api::V1::Ingredients::OverviewSerializer < BaseSerializer
  attributes :name
  
  attribute :category do |object|
    BASE::Categories::OverviewSerializer.new(object.category)
  end
end
