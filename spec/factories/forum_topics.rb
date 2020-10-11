# FactoryBot.define do
#   factory :forum_topic do
#     association owner, factory: %i[user admin]
#     forum
#     title { Faker::Movie.unique.quote }
#     content { Faker::Markdown.sandwich(sentences: 5) }
#   end
# end
