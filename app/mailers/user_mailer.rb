class UserMailer < ActionMailer::Base
  default from: "networkmill@gmail.com"

  def welcome_email(email)
    @greeting = "Hi"

    mail to: email, subject: "Sign Up Confirmation - Welcome to NetworkMill"
  end

  # To send email use: UserMailer.send_contacts(user, contacts).deliver
  def send_contacts(user, contacts_id)
  	@contacts = []
  	contacts_id.each do |c|
  		@contacts << Contact.find_by_id(c)
  	end
  	mail to: user.email, subject: "Awesome People to Contact This Week"
    puts "sent email to #{user.email}!"
  end

  def low_contacts(user)
    mail to: user.email, subject: "Hey, you need to add contacts"
  end
end
