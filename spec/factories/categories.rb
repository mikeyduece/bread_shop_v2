FactoryBot.define do
  factory :category do
      name { Faker::TvShows::RickAndMorty.unique.character }
  end
end
