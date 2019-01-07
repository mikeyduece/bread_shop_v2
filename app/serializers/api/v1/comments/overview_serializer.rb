class Api::V1::Comments::OverviewSerializer < BaseSerializer
  attributes :body, :parent_id
  belongs_to :recipe

  attribute :user do |object|
    BASE::Users::OverviewSerializer.new(object.user)
  end

  attribute :replies do |object|
    BASE::Comments::OverviewSerializer.new(object.replies)
  end
end
