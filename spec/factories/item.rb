FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 8) }
    image_id { Faker::Lorem.characters(number: 8) }
    introduction { Faker::Lorem.characters(number: 50) }
    price { Faker::Number.number(digits: 5) }
    stock { Faker::Number.number(digits: 2) }
  end
end
