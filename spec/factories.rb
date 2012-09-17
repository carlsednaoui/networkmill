# Create factories with Factory Girl

FactoryGirl.define do
  # Create a sequence of unique factory users
  sequence(:email) { |n| "networkmill+#{n}@gmail.com"}


  factory :user do
    email
    password "factorypassword"
    after(:build) {|user| BetaInvite.create({:email => "#{user.email}"})}
  end 
end