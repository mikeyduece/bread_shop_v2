FactoryBot.define do
  factory :family do
    sequence :name do
      @name ||= %i[lean soft rich sweet slack]
      
      @name.sample
    end
  end
end
