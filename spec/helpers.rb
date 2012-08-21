module Helpers
  include FactoryGirl::Syntax::Methods

  # Create and login a user
  def log_web_user_in
    # Remeber to set :js => true
    user = create(:user, name: "im_a_test_user")

    visit root_path
    page.find('.sign-in').trigger(:mouseover)
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "hit it"
  end

  # Create a contact
  def create_test_contact
    log_web_user_in
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
end