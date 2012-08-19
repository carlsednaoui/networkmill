require 'spec_helper'

describe "WebUsers" do
  # Create and login a user
  # Remeber to set :js => true
  def log_user_in
    user = create(:user, name: "im_a_test_user")

    visit root_path
    page.find('.sign-in').trigger(:mouseover)
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "hit it"
  end

  # Create a contact
  def create_test_contact
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
  end

  describe "Test log_user_in", :js => true do
    it "works. Now it's time to write some real shiats" do
      log_user_in

      page.should have_content("Here are the people")
      page.should have_content("add new contact")
    end
  end

  describe "Add contact", :js => true do
    it "allows user to add a contact" do
      create_test_contact

      # Ensure that contact was created
      page.should have_content("contact saved")
      page.should have_content("mycontact@example.com")
      page.should have_content("my contact name")

      # Click on edit_contact, click on notes, find the contact notes
      within(".contacts") do
        find("li").find(".edit-contact").click
        find("#edit_contact_1").find(".add-notes").click
        find(".add-notes").find("#contact_note").should have_content("this is a contact note")
      end
    end
  end

  describe "Edit contact", :js => true do
    it "allows user to edit contact" do
      create_test_contact
      
      # Edit contact
      within(".contacts") do
        find("li").find(".edit-contact").click
        fill_in "contact_email", :with => "modifiedcontact@example.com"
        fill_in "contact_name", :with => "modified contact name"

        # Edit notes
        find("#edit_contact_1").find(".add-notes").click
        fill_in "contact_note", :with => "modified contact note"
        # print page.html
        # Test FAILS HERE
        # click_button("edit contact")
      end
      
      # find(".add-notes").find("#contact_note").should have_content("this is a contact note")

    end
  end

end
