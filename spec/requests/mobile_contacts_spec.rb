require 'spec_helper'

describe "Mobile Users" do
  include Helpers

  describe "Test log_mobile_user_in", :js => true do
    it "works. Now it's time to write some real shiats" do
      # Remember to run $ rails s -e test
      
      user = create(:user, name: "im_a_test_user")

      visit("http://m.lvh.me:3000")
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "sign in"

      page.should have_css("#write-note")
      page.should have_css("body#mobile")

      find(".cog").click
      page.should have_content("#{user.email}")
      page.should have_content("Im A Test User")
    end
  end

  describe "add a contact", :js => true do
    it "adds a contact on your mobile phone" do
      # Create user
      user = create(:user, name: "im_a_test_user")

      # Log user on mobile
      # Remember to run $ rails s -e test
      visit("http://m.lvh.me:3000")
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "sign in"

      # Ensure that page loads correctly
      page.should have_css("#write-note")
      page.should have_css("body#mobile")

      find(".cog").click
      page.should have_content("#{user.email}")
      page.should have_content("Im A Test User")

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

      page.should have_content("#{test_contact_name}")
      page.should have_content("#{test_contact_email}")
    end
  end
end