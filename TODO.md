# To Do
- Allow users to reset password (with Devise) - once deployed
- Look over any potential security holes
- Do not allow user to ask for a 'contact intensity' that is higher than the number of contacts they have in their list, or we'll have many bugs on our hands. For example, if a user sets contact intensity to 10 then only has 3 people on their list, we will end up repeating the same people. I disallowed this in the random picking method, so currently it will throw an error, but we should handle this with a validation or on the front end. CS: one thing to note is that when a user creates an account, by default they will have 0 contacts. Lets discuss this piece of logic next time we meet.

# Notes
- From Devise "Ensure you have defined default url options in your environments files. Here is an example of default_url_options appropriate for a development environment in config/environments/development.rb: config.action_mailer.default_url_options = { :host => 'localhost:3000' } In production, :host should be set to the actual host of your application."
- To run delayed job in development use $rake jobs:work
- To run delated job in production http://railscasts.com/episodes/171-delayed-job-revised && https://devcenter.heroku.com/articles/delayed-job
