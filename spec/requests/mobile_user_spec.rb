require 'spec_helper'

describe "Mobile Users" do
  describe "GET Homepage" do
    it "goes to homepage" do
      visit("http://m.networkmill.dev")

      page.should have_css("body#mobile")
      page.should have_css("#sign-in")
    end
  end


  describe "Register user" do
    it "allows new users to register with an email address and password" do
      visit("http://m.networkmill.dev")
      click_link "sign up"

      # Take user to web app
      page.should_not have_css("body#mobile")
      page.should have_content("networkmill keeps track of your contacts")
    end
  end


  describe "Signin user" do
    it "allows a registered user to signin" do
      user = create(:user, name: "im_a_test_user")

      visit("http://m.networkmill.dev")
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


  describe "Signin user - without name" do
    it "allows a registered user without name to signin" do
      user = create(:user)

      visit("http://m.networkmill.dev")
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "sign in"

      page.should have_css("#write-note")
      page.should have_css("body#mobile")

      find(".cog").click
      page.should have_content("#{user.email}")
      find('#name').should have_content("")
    end
  end

  
  describe "Signin unregistered user", :js => true do
    it "should not allow non registered users to signin" do
      visit("http://m.networkmill.dev")
      fill_in "user_email", :with => "notarealuser@example.com"
      fill_in "user_password", :with => "fakepassword"
      click_button "sign in"

      page.should_not have_css("#write-note")
      page.should have_css("body#mobile")
      # TODO Page should have sign-in-error validation
    end
  end
end
