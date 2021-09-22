FactoryBot.define do
  factory :post_comment do
    body { Faker::Lorem.characters(number: 30) }
    post
    user
  end
end
