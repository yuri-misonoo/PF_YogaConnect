FactoryBot.define do
  factory :post do
    body { Faker::Lorem.characters(number:50) }
  end
end