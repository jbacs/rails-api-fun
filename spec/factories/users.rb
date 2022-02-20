FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Asdf123' }
  end
end
