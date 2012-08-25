#===============================
# Useful commands:
# $rake db:test:prepare
# $rails g integration_test foobar
# $rake spec:requests
# $save_and_open_page
# $print page.html
# $tail -f log/test.log
#===============================

require 'spec_helper'

describe "Web Users" do
  describe "GET Homepage" do
    it "goes to homepage" do
      visit root_path
      page.should have_content("networkmill keeps track of your contacts")
    end
  end


  describe "Register user", :js => true do
    it "allows new users to register with an email address and password" do
      visit root_path

      within("#sign-up") do
        fill_in "user_email", :with => "myemail@example.com"
        fill_in "user_password", :with => "mypassword"
      end
      click_button "let's go"

      page.should have_content("Let's get to know each other, why don't you tell")
    end
  end


  describe "Signin user", :js => true do
    it "allows a registered user to signin" do
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


  describe "Signin user - without name", :js => true do
    it "allows a registered user without name to signin" do
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


  describe "Signin unregistered user", :js => true do
    it "should not allow non registered users to signin" do
      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => "notarealuser@example.com"
      fill_in "user_password", :with => "fakepassword"
      click_button "hit it"

      page.should_not have_content("Here are the people")
      page.should_not have_content("Let's get to know each other")
      page.find('.sign-in').trigger(:mouseover)
      page.should have_css("#sign-in-error")
    end
  end


  describe "Edit user profile", :js => true do
    include Helpers
    it "should allow user to change name" do
      log_web_user_in
      page.should have_content("Here are the people")
      page.should have_content("add new contact")

      page.find('.account').trigger(:mouseover)
      click_link "preferences"
      page.should have_content("Edit Introductory Email")

      # Change user name and email
      within(".address-fields") do
        fill_in "user_name", :with => "new funky name"
        fill_in "user_email", :with => "newemail@tits.com"
      end
      click_button "update"
      page.should have_content("preferences have been updated")

      page.find('.account').trigger(:mouseover)
      click_link "preferences"

      find_field('user_name').value.should have_content("new funky name")
      find_field('user_email').value.should have_content("newemail@tits.com")
    end
  end

end