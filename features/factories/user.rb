FactoryGirl.define do
  factory :user do
    email       { Faker::Internet.email }
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    user_type   { 'customer' }

    factory :stuff_user do
      after(:build) do |user|
        user.user_type = 'stuff'
        user.password = '123123123'
      end
    end
  end
end