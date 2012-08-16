require 'spec_helper'

describe "Users" do
  describe "GET Homepage" do
    it "goes to homepage" do
      visit root_url
      page.should have_content("networkmill keeps track of your contacts and makes")
    end
  end

  # describe "user registration" do
  #   it "allows new users to register with an email address and password" do
  #     visit new_user_registration_path

  #     fill_in "user[email]", :with => "myemail@example.com"
  #     fill_in "user_password", :with => "mypassword"
  #     click_button "Sign up"

  #     page.should have_content("Let's get to know each other, why don't you tell")
  #   end
  # end

  ### NOTE THIS IS DRIVING TO MOBILE PAGE FOR SOME REASON
  describe "user signin" do
    it "should allow a registered user to sign in" do
      user = create(:user, name: "im_a_test_user")
      # visit new_user_session_path
      visit('http://localhost:3000/users/sign_in')
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "hit it"
      # save_and_open_page
      page.should have_content("Here are the people you want to stay in touch with")
     end

     it "should not allow an unregistered user to sign in" do
      visit new_user_session_path
      fill_in "Email", :with => "notarealuser@example.com"
      fill_in "Password", :with => "fakepassword"
      click_button "hit it"
      page.should_not have_content("Event Mode")
     end
   end
end