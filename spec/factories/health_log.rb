FactoryBot.define do
  factory :health_log do
    weight { '50' }
    temperature { '36' }
    exercise { Faker::Lorem.characters(number:30) }
    morning { Faker::Lorem.characters(number:30) }
    lunch { Faker::Lorem.characters(number:30) }
    dinner { Faker::Lorem.characters(number:30) }
    memo { Faker::Lorem.characters(number:30) }
    user
  end
end