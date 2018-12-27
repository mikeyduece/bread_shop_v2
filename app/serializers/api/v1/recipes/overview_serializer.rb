class Api::V1::Recipes::OverviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :total_percentage, :units, :family, :ingredients

  attribute :user do |object|
    Users::OverviewSerializer.new(object.user)
  end

  attribute :total_percentage do |object|
    "#{object.total_percentage}%"
  end

  attribute :name do |object| 
    object.name.titleize
  end

  attribute :family do |object|
    Families::OverviewSerializer.new(object.family)
  end
end
