require 'spec_helper'

describe "WebUsers" do
  def log_user_in
    # Remeber to set :js => true
    user = create(:user, name: "im_a_test_user")

    visit root_path
    page.find('.sign-in').trigger(:mouseover)
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "hit it"

    page.should have_content("Here are the people")
  end

  describe "Test log_user_in", :js => true do
    it "works. Now it's time to write some real shiats" do
      log_user_in
      page.should have_content("add new contact")
    end
  end

  describe "Add contact", :js => true do
    it "allows user to add a contact" do
      log_user_in
      click_link("add new contact")

      within(".new_contact") do
        fill_in "contact_email", :with => "mycontact@example.com"
        fill_in "contact_name", :with => "my contact name"
      end

      # Add notes to a contact
      find(".add-notes").click
      within(".new_contact") do
        fill_in "contact_note", :with => "this is a contact note"
      end

      click_button("add contact")

      # Ensure that contact was created
      page.should have_content("contact saved")
      page.should have_content("mycontact@example.com")
      page.should have_content("my contact name")

      # Click on edit_contact, click on notes, find the contact notes
      within(".contacts") do
        find("li").find(".edit-contact").click
        # find("#edit_contact_1").should have_content("add notes")
        find(".add-notes").click
        within(".add-notes") do
          find("#contact_note").should have_content("this is a contact note")
        end
      end
    end
  end
end
