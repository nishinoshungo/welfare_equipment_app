FactoryBot.define do
  factory :contact do
    name {Faker::Lorem.characters(number: 6)}
    email {Faker::Internet.email}
    subject {Faker::Lorem.characters(number: 10)}
    message {Faker::Lorem.characters(number: 200)}
  end
end