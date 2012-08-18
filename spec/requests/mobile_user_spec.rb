require 'spec_helper'


describe "Mobile Users" do
  describe "GET Homepage" do
    it "goes to homepage" do
      visit("http://m.lvh.me:3000/")

      page.should have_css("body#mobile")
      page.should have_css("#sign-in")
    end
  end

  describe "Register user" do
    it "allows new users to register with an email address and password" do
      visit("http://m.lvh.me:3000/")
      click_link "sign up"

      # Take user to web app
      page.should_not have_css("body#mobile")
      page.should have_content("networkmill keeps track of your contacts")
    end
  end

  describe "Sign in user" do
    it "should allow a registered user to sign in" do
      user = create(:user)

      visit("http://m.lvh.me:3000/")
      fill_in "user_email", :with => user.email
      fill_in "user_password", :with => user.password
      click_button "sign in"

      page.should have_css("#write-note")
      page.should have_css("body#mobile")
    end
  end
end
