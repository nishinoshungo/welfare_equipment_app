FactoryBot.define do
  factory :admin do
    email { "test@test.com" }
    password { "adminpass" }
    encrypted_password { "adminpass" }
  end
end
