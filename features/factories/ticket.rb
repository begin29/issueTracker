FactoryGirl.define do
  factory :ticket do
    subject     { Faker::Internet.email }
    description { Faker::Name.first_name }
    customer_id { create(:user).id }

    # factory :stuff_user do
    #   after(:build) do |user|
    #     user.user_type = 'stuff'
    #     user.password = '123123123'
    #   end
    # end
  end
end