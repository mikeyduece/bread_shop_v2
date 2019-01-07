class Api::V1::Comments::OverviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body
  belongs_to :user
  belongs_to :recipe
end
