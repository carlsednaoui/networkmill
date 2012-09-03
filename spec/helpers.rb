#===============================
# Useful commands:
# $rake db:test:prepare
# $rails g integration_test foobar
# $rake spec:requests
# $save_and_open_page
# $print page.html
# $tail -f log/test.log
# Remember to run $ rails s -e test
#===============================

# Allow user to upload profile picture
# Allow user to change password
# Allow user to send himself test email
# Allow user to unsubsribe (try sending him an email)

module Helpers

  def create_factory_user
    user = create(:user, name: "im_a_test_user")
    return user
  end

  # ===============================
  # Create and login a web user
  # ===============================
  def log_web_user_in
    # Remeber to set :js => true
    user = create_factory_user

    visit root_path
    page.find('.sign-in').trigger(:mouseover)
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "hit it"

    # Make sure you're logged in
    page.should have_content("Here are the people")
    page.should have_content("add new contact")

    return user
  end

  # ===============================
  # Create a web contact
  # ===============================
  def create_web_test_contact
    # Remeber to set :js => true
    log_web_user_in

    # Create contact
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
      find("#edit_contact_1").find(".add-notes").click
      find(".add-notes").find("#contact_note").should have_content("this is a contact note")
    end
  end

  # ===============================
  # Create and login a web user
  # ===============================
  def log_mobile_user_in
    # Remember to run $ rails s -e test
    # Remeber to set :js => true
    
    user = create_factory_user

    visit("http://m.lvh.me:3000")
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "sign in"

    # Ensure that login worked
    page.should have_css("#write-note")
    page.should have_css("body#mobile")

    find(".cog").click
    page.should have_content("#{user.email}")
    page.should have_content("Im A Test User")

    return user
  end

  # ===============================
  # Create user and turn on networkmode
  # ===============================
  def turn_networkmode_on
    user = log_mobile_user_in
    
    # Update mobile preferences
    find(".cog").click
    page.should have_select('network_mode', :selected => 'Off')
    select("On", :from => "network_mode")
    fill_in "signature", :with => "this is my awesome intro"
    click_button "start networking"

    find(".cog").click
    page.should have_select('network_mode', :selected => 'On')
    page.should have_content("this is my awesome intro")
    find('#counter').should have_content('0')    

    return user
  end

end
