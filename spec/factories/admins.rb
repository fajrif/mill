FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    full_name { Faker::Name.name }
  end
end
