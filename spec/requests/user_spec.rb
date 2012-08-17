require 'spec_helper'

# save_and_open_page

describe "Users" do
  describe "GET Homepage" do
    it "goes to homepage" do
      visit root_path
      page.should have_content("networkmill keeps track of your contacts and makes")
    end
  end

  # describe "Register user" do
  #   it "allows new users to register with an email address and password" do
  #     visit root_path

  #     click_link "sign up"
  #     fill_in "user_email", :with => "myemail@example.com"
  #     fill_in "user_password", :with => "mypassword"
  #     save_and_open_page

  #     click_button "let's go"

  #     page.should have_content("Let's get to know each other, why don't you tell")
  #   end
  # end

  describe "Sign in user", :js => true do
    it "should allow a registered user to sign in" do
      user = create(:user, name: "im_a_test_user")

      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "hit it"
      page.should have_content("Here are the people you want to stay in touch with")
     end
   end

  describe "Sign in user - without name", :js => true do
    it "user without name" do
      user = create(:user)
      
      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "hit it"
      page.should have_content("Here are the people you want to stay in touch with")
     
      page.find('.account').trigger(:mouseover)
      click_link "preferences"
      page.should have_content("Let's get to know each other, why don't you tell")
     end
   end

  describe "Sign in unregistered user", :js => true do
    it "non users shouldnt be able to log in" do
      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => "notarealuser@example.com"
      fill_in "user_password", :with => "fakepassword"
      click_button "hit it"
      page.should_not have_content("Here are the people")
    end
  end
end