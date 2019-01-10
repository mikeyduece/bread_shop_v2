class Api::V1::Forums::PrivateSerializer < BaseSerializer
  attributes :title, :body

  attribute :user do |object|
    BASE::Users::OverviewSerializer.new(object.user)
  end
end