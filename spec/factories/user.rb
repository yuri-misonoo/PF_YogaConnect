FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 30) }
    goal_weight { Faker::Lorem.characters(number: 5) }
    goal { Faker::Lorem.characters(number: 30) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
