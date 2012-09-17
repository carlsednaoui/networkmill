# Create factories with Factory Girl

FactoryGirl.define do
  # Create a sequence of unique factory users
  sequence(:email) { |n| "networkmill+#{n}@gmail.com"}


  factory :user do
    email
    password "factorypassword"

    # Add factory user email to beta invite
    after(:build) {|user| BetaInvite.create({:email => "#{user.email}"})}
  end 
end