require 'spec_helper'
include Helpers

describe "Mobile Users" do

  describe "GET Homepage" do
    it "goes to homepage" do
      # Remember to run $ rails s -e test
      visit("http://m.lvh.me:3000")

      page.should have_css("body#mobile")
      page.should have_css("#sign-in")
    end
  end

  describe "Register user" do
    it "allows new users to register with an email address and password" do
      visit("http://m.lvh.me:3000")
      page.should have_css("body#mobile")
      click_link "sign up"

      # Take user to the web app
      page.should_not have_css("body#mobile")
      page.should have_content("networkmill keeps track of your contacts")
    end
  end

  describe "Signin user" do
    it "allows a registered user to signin" do
      log_mobile_user_in
    end
  end

  describe "Signin user - without name" do
    it "allows a registered user without name to signin" do
      user = create(:user)

      # Signin
      visit("http://m.lvh.me:3000")
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "sign in"

      # Verify login worked
      page.should have_css("#write-note")
      page.should have_css("body#mobile")

      find(".cog").click
      page.should have_content("#{user.email}")
      find('#bio').find('#name').should have_content("") # name should be blank
    end
  end
  
  describe "Signin unregistered user", :js => true do
    it "should not allow non registered users to signin" do
      visit("http://m.lvh.me:3000")

      # Try to login
      fill_in "user_email", :with => "notarealuser@example.com"
      fill_in "user_password", :with => "fakepassword"
      click_button "sign in"

      # Page should throw error
      page.should_not have_css("#write-note")
      page.should have_css("body#mobile")
      page.should have_css("#sign-in-error")
      page.should have_content("Invalid email or password.")
    end
  end

  describe "Turn networkmode on" do
    it "makes sure mobile preferences work" do      
      turn_networkmode_on
    end
  end

end
