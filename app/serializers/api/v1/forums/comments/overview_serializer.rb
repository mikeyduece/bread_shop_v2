class Api::V1::Forums::Comments::OverviewSerializer < BaseSerializer
  attributes :body

  attribute :user do |object|
    BASE::Users::OverviewSerializer.new(object.user)
  end
end