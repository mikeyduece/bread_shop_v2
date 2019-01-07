class Api::V1::Recipes::OverviewSerializer < BaseSerializer
  attributes :name, :total_percentage, :number_of_portions, :weight_per_portion, :units, :family, :ingredients

  attribute :user do |object|
    BASE::Users::OverviewSerializer.new(object.user)
  end

  attribute :total_percentage do |object|
    "#{object.total_percentage}%"
  end

  attribute :name do |object| 
    object.name.titleize
  end

  attribute :family do |object|
    BASE::Families::OverviewSerializer.new(object.family)
  end

  attributes :comments do |object|
    BASE::Comments::OverviewSerializer.new(object.comments.roots)
  end
end
