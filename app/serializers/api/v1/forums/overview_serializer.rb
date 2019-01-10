class Api::V1::Forums::OverviewSerializer < Api::V1::Forums::PrivateSerializer

  attribute :comments do |object|
    BASE::Forums::Comments::OverviewSerializer.new(object.comments)
  end
end