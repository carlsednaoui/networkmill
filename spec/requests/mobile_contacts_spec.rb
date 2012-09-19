require 'spec_helper'
include Helpers

describe "Mobile Contacts" do

  describe "Test mobile user login", :js => true do
    it "works. Now it's time to write some real shiats" do
      # Remember to run $ rails s -e test
      log_mobile_user_in
    end
  end

  describe "add a contact", :js => true do
    it "adds a contact on your mobile phone" do
      # Create and login mobile user
      user = log_mobile_user_in

      # Create contact
      test_contact_email = "testcontact@example.com"
      test_contact_name = "test contact"

      visit("http://m.lvh.me:3000/networking")
      fill_in "name", :with => test_contact_name
      fill_in "email", :with => test_contact_email
      click_button "send"

      # Go to webapp to find contact in dashboard
      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "hit it"

      # Disable the welcome screen
      no_tutorial

      # Make sure contact is there
      page.should have_content("#{test_contact_name}")
      page.should have_content("#{test_contact_email}")
    end
  end

  describe "network mode in action", :js => true do
    it "allows a mobile user to add contacts to their networking queue" do
      # Create and login mobile user, turn networkmode on
      user = turn_networkmode_on

      # Create contact 1
      test_contact_email = "testcontact@example.com"
      test_contact_name = "test contact"

      visit("http://m.lvh.me:3000/networking")
      fill_in "name", :with => test_contact_name
      fill_in "email", :with => test_contact_email
      click_button "send"

      find('#counter').should have_content('1')

      # Create contact 2
      test_contact_2_email = "testcontact2@example.com"
      test_contact_2_name = "test contact 2"

      visit("http://m.lvh.me:3000/networking")
      fill_in "name", :with => test_contact_2_name
      fill_in "email", :with => test_contact_2_email
      click_button "send"

      find('#counter').should have_content('2')

      # Go to webapp to find contact in dashboard
      visit root_path
      page.find('.sign-in').trigger(:mouseover)
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "hit it"

      # Disable the welcome screen
      no_tutorial

      # Make sure contacts are there
      page.should have_content("#{test_contact_name}")
      page.should have_content("#{test_contact_email}")
      page.should have_content("#{test_contact_2_name}")
      page.should have_content("#{test_contact_2_email}")
    end
  end

end
