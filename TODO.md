# To Do
- Allow users to reset password (with Devise) - once deployed
- Look over any potential security holes
- Do not allow user to ask for a 'contact intensity' that is higher than the number of contacts they have in their list, or we'll have many bugs on our hands. For example, if a user sets contact intensity to 10 then only has 3 people on their list, we will end up repeating the same people. I disallowed this in the random picking method, so currently it will throw an error, but we should handle this with a validation or on the front end. CS: one thing to note is that when a user creates an account, by default they will have 0 contacts. Lets discuss this piece of logic next time we meet.

# Notes
- From Devise "Ensure you have defined default url options in your environments files. Here is an example of default_url_options appropriate for a development environment in config/environments/development.rb: config.action_mailer.default_url_options = { :host => 'localhost:3000' } In production, :host should be set to the actual host of your application."
- run mailer: rake mill:all
- single: rake mill:single[1]

# The Future
- Task that looks users with less than 5 contacts and reminds them
- A property on user so that we can say they were already reminded
- A way for the user to "deactivate" account
- A way to unsubscribe (link to account settings in email)
- User has_many Emails (user_id, sent_to, body, contacts)
- Create an email on the user as soon as it gets sent, make sure that's working
- Disable everything if you have less than 5 contacts
- User edit page - should be able to change password and such through devise
- Introduction on first login
  - ask for your name
  - ask for desktop client or not
  - gmail connect piece (low priority)
  - set how many people you want to get per email

# Mobile App
- Namespace, get m.networkmill.com to pull it up
- Login screen
- Mobile dashboard (picture - carrierwave, personal message, event queue checkbox)
- Networking screen (form w/ name, email, and optional personalized message)
- When send gets hit, friend sent email immediately, you get an email sent or queued
- Logic for queueing in event mode
  - if event mode, add to queue, send 5 hours later
  - if not send it right away