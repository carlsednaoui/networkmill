#===============================
# Useful methods available:
# $save_and_open_page
# $print page.html
#===============================

require 'spec_helper'

describe "Users" do
  describe "GET Homepage" do
    it "goes to homepage" do
      visit root_path
      page.should have_content("networkmill keeps track of your contacts and makes")
    end
  end

  describe "Register user", :js => true do
    it "allows new users to register with an email address and password" do
      visit root_path

      within("#sign-up") do
        fill_in 'user_email', :with => 'myemail@example.com'
        fill_in "user_password", :with => "mypassword"
      end
      click_button "let's go"

      page.should have_content("Let's get to know each other, why don't you tell")
    end
  end

  describe "Sign in user", :js => true do
    it "should allow a registered user to sign in" do
      user = create(:user, name: "im_a_test_user")

      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "hit it"

      page.should have_content("Here are the people")

      page.find('.account').trigger(:mouseover)
      click_link "preferences"
      page.should_not have_content("Let's get to know each other")
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
      
      page.should have_content("Here are the people")
     
      page.find('.account').trigger(:mouseover)
      click_link "preferences"
      page.should have_content("Let's get to know each other")
     end
   end

  describe "Sign in unregistered user", :js => true do
    it "non users should not be able to sign in" do
      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => "notarealuser@example.com"
      fill_in "user_password", :with => "fakepassword"
      click_button "hit it"

      page.should_not have_content("Here are the people")
      page.should_not have_content("Let's get to know each other")
      page.find('.sign-in').trigger(:mouseover)
      print page.html
      page.should have_css("#sign-in-error")
    end
  end
end