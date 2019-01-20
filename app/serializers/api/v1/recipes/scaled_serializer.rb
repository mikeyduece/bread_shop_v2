class Api::V1::Recipes::ScaledSerializer < BaseSerializer
  attribute :number_of_portions do |_, params|
    params[:params][:number_of_portions]
  end

  attribute :weight_per_portion do |_, params|
    params[:params][:weight_per_portion]
  end

  attribute :ingredients do |object, params|
    object.new_totals(params: params[:params])
  end
end
