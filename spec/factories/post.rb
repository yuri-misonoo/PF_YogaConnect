FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number:50) }
    user
  end
end