FactoryBot.define do
  factory :customer do
    last_name {Faker::Lorem.characters(number: 4)}
    first_name {Faker::Lorem.characters(number: 4)}
    last_name_kana {Faker::Lorem.characters(number: 4)}
    first_name_kana {Faker::Lorem.characters(number: 4)}
    postal_code {Faker::Number.number(digits: 7)}
    address {Faker::Lorem.characters(number: 10)}
    telephone_number {Faker::Number.number(digits: 10)}
    burden_ratio {1}
    email {Faker::Internet.email}
    password {"password"}
    encrypted_password {"password"}
  end
end