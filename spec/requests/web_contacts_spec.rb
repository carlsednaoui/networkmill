require 'spec_helper'
include Helpers

describe "Web Users" do

  describe "Test log_web_user_in", :js => true do
    it "works. Now it's time to write some real shiats" do
      log_web_user_in
    end
  end

  describe "Add and edit contact", :js => true do
    it "allows user to add and edit a contact" do
      # Create and login user, create contact
      create_web_test_contact

      # Edit contact
      within(".contacts") do
        find("li").find(".edit-contact").click
        fill_in "contact_email", :with => "modifiedcontact@example.com"
        fill_in "contact_name", :with => "modified contact name"

        # Edit notes
        find("#edit_contact_1").find(".add-notes").click
        fill_in "contact_note", :with => "modified contact note"
        click_button("edit contact")
      end

      page.should have_content("Contact was successfully updated")
      page.should_not have_content("mycontact@example.com")
      page.should_not have_content("my contact name")
      page.should have_content("modifiedcontact@example.com")
      page.should have_content("modified contact name")

      # Click on edit_contact, click on notes, find the edited contact notes
      within(".contacts") do
        find("li").find(".edit-contact").click
        find("#edit_contact_1").find(".add-notes").click
        find(".add-notes").find("#contact_note").should_not have_content("this is a contact note")
        find(".add-notes").find("#contact_note").should have_content("modified contact note")
      end
    end
  end

  describe "Delete contact", :js => true do
    it "allows a user to delete contacts" do
      create_web_test_contact

      # Click on delete_contact
      find(".contacts").find("li").find(".delete-contact").click

      # Ensure that contact was created
      page.should have_content("contact deleted")
      page.should_not have_content("mycontact@example.com")
      page.should_not have_content("my contact name")
    end
  end

end
