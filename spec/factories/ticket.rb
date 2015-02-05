FactoryGirl.define do
  factory :ticket do
    subject     { Faker::Internet.email }
    description { Faker::Name.first_name }
    customer_id { create(:user).id }
  end
end