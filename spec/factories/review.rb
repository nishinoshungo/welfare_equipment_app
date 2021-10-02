FactoryBot.define do
  factory :review do
    comment {Faker::Lorem.characters(number:10)}
    rate {3}
  end
end