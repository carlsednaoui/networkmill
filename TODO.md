_I restructured this file a little bit to make it more organized for us. Bugs can apply to anything and are listed at the top - when you find something that's messed up just toss it in there. If it's not super obvious, include a screenshot. The rest of the categories are more or less to-do lists / road maps for us. As soon as you finish one, commit, delete from here, and push._

# Bugs
- edit user validation renders the "edit" path which shows the user ID in the URL

# Web App
- Add a link to user settings to our email (so that they can unsubscribe)

# Mobile App
- Namespace, get m.networkmill.com to pull it up
- Login screen
- Mobile dashboard (picture - carrierwave, personal message, event queue checkbox)
- Networking screen (form w/ name, email, and optional personalized message)
- When send gets hit, friend sent email immediately, you get an email sent or queued
- Logic for queueing in event mode
  - if event mode, add to queue, send 5 hours later
  - if not send it right away

# Design
- Welcome piece that comes up on first login
    - ask for your name
    - ask for desktop client or not
    - gmail connect piece (low priority)
    - set how many people you want to get per email
    - Motivate users to add more contacts if they have less than 5
- Better account settings/sign out dropdown menu
- mobile app: sign in screen and adjust default email screen
- Figure out which navigation links we should have
- More thorough deomonstration of how the app works on the homepage
- User preferences screen
- About and contact pages
- Footer?

# Front End
- Dashboard - edit, delete, and add contact should all be ajax
- User preferences screen
- Do not allow user to ask for a 'contact intensity' that is higher than the number of contacts they have in their list (use data attribute and javascript)
- Add unicode down triangle after account email to indicate dropdown

# Done
- Task that looks users with less than 5 contacts and reminds them (moved this to mill:all process inside User Model)
- A way for the user to "deactivate" account (using devise defaults)
- User edit page - should be able to change password and such through devise
- Add "notes" to contacts (in case there is one)
- Add email signature to user
- When user updates profile, route to dashboard_path
- User has_many Emails (user_id, sent_to, body, contacts)
- If new user - route to edit_profile_path
- Allow users to reset password (using devise defaults)
- A property on user so that we can say they were already reminded of low_contacts? (we can do this by looking up in the email model and see if user has received said email - right now a user will get an email if user.contact_intensity > contacts.count && contacts.count < 5)
- Create an email on the user as soon as it gets sent

# Notes
- From Devise "Ensure you have defined default url options in your environments files. Here is an example of default_url_options appropriate for a development environment in config/environments/development.rb: config.action_mailer.default_url_options = { :host => 'localhost:3000' } In production, :host should be set to the actual host of your application."
- run mailer: `rake mill:all`
