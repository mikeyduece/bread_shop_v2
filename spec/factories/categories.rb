FactoryBot.define do
  factory :category do
      name { Faker::TvShows::RickAndMorty.character }
  end
end
