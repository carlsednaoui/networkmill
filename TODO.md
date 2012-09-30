# Design
- Welcome piece that comes up on first login
    - ask for your name
    - ask for desktop client or not
    - gmail connect piece (low priority)
    - set how many people you want to get per email
    - Motivate users to add more contacts if they have less than 5
- Better account settings/sign out dropdown menu
- Figure out which navigation links we should have
- More thorough deomonstration of how the app works on the homepage
- User preferences screen
- About and contact pages
- Footer?

# Front End
- User preferences screen

# Notes
- From Devise "Ensure you have defined default url options in your environments files. Here is an example of default_url_options appropriate for a development environment in config/environments/development.rb: config.action_mailer.default_url_options = { :host => 'localhost:3000' } In production, :host should be set to the actual host of your application."
- run mailer: `rake mill:all`
- Uncomment mailer in User Model and Contact Controller
