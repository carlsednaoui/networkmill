# To Do
- Look over any potential security holes
- Remove contacts link on Dashboard - everything should happen from the dashboard
- Allow users to unsubscribe from our emails (link to account settings in email)
- Fix Email when you run the mill (email.contacts looks like this "---\n- 4\n- 1\n- 8\n")
- When you run the mill and user has > 5 contacts but < than contact intensity, nothing happens - fix this
- Limit user contact intensity
  - Do not allow user to ask for a 'contact intensity' that is higher than the number of contacts they have in their list, or we'll have many bugs on our hands. For example, if a user sets contact intensity to 10 then only has 3 people on their list, we will end up repeating the same people. I disallowed this in the random picking method, so currently it will throw an error, but we should handle this with a validation or on the front end.
  - One thing to note is that when a user creates an account, by default they will have 0 contacts. Lets discuss this piece of logic next time we meet.
  - Do not allow a user to have an intensity > the # of contacts they have - OR - have a message that says "hey, you're contact intensity is higher than the number of contacts you have, we will only sent you x contacts" $while user.contact_intensity > user.contacts.count user.contact_intensity = user.contacts.count (or something like that)
- Introduction on first login (right now user if being directed to user_edit_path, we could add a "welcome screen")
  - ask for your name
  - ask for desktop client or not
  - gmail connect piece (low priority)
  - set how many people you want to get per email
	- Motivate users to add more contacts if they have less than 5

# Mobile App
- Namespace, get m.networkmill.com to pull it up
- Login screen
- Mobile dashboard (picture - carrierwave, personal message, event queue checkbox)
- Networking screen (form w/ name, email, and optional personalized message)
- When send gets hit, friend sent email immediately, you get an email sent or queued
- Logic for queueing in event mode
  - if event mode, add to queue, send 5 hours later
  - if not send it right away

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
- run mailer: rake mill:all
- single: rake mill:single[1] (commented this out to avoid getting rake errors)