class Api::V1::Recipes::OverviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :total_percentage, :number_of_portions, :weight_per_portion, :units, :family, :ingredients

  attribute :user do |object|
    Api::V1::Users::OverviewSerializer.new(object.user)
  end

  attribute :total_percentage do |object|
    "#{object.total_percentage}%"
  end

  attribute :name do |object| 
    object.name.titleize
  end

  attribute :family do |object|
    Api::V1::Families::OverviewSerializer.new(object.family)
  end
end
