class Api::V1::Forums::Comments::OverviewSerializer < BaseSerializer
  attributes :body

  attribute :replies do |object|
    BASE::Comments::OverviewSerializer.new(object.replies)
  end

  attribute :user do |object|
    BASE::Users::OverviewSerializer.new(object.user)
  end
end