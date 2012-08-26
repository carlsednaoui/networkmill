# Create factories with Factory Girl

FactoryGirl.define do
  factory :user do
    # Create a sequence of unique factory users
    sequence(:email) { |n| "networkmill+#{n}@gmail.com"}
    password "factorypassword"
  end 
end