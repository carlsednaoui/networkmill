_I restructured this file a little bit to make it more organized for us. Bugs can apply to anything and are listed at the top - when you find something that's messed up just toss it in there. If it's not super obvious, include a screenshot. The rest of the categories are more or less to-do lists / road maps for us. As soon as you finish one, commit, delete from here, and push._

# Mobile App
- Networking screen (form w/ name, email, and optional personalized message)
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
- Add unicode down triangle after account email to indicate dropdown

# Notes
- From Devise "Ensure you have defined default url options in your environments files. Here is an example of default_url_options appropriate for a development environment in config/environments/development.rb: config.action_mailer.default_url_options = { :host => 'localhost:3000' } In production, :host should be set to the actual host of your application."
- run mailer: `rake mill:all`
- Uncomment mailer in User Model and Contact Controller
