class UserMailer < ActionMailer::Base
  default from: "networkmill@gmail.com"

  def welcome_email(user)
    @greeting = "Hi"

    mail to: user.email, subject: "Sign Up Confirmation - Welcome to NetworkMill"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "welcome_mail")
  end

  def low_contacts(user)
    mail to: user.email, subject: "Hey, you need to add contacts"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "low_contacts_mail")
  end

  def send_contacts(user, contacts_id)
    @contacts = []

  	contacts_id.each do |c|
  		@contacts << Contact.find_by_id(c)
  	end
  	mail to: user.email, subject: "Awesome People to Contact This Week"
    puts "sent email to #{user.email}!"

    Email.create(:user_id => user.id, :sent_to => user.email, :title => "mill_mail", :contacts => contacts_id)
  end
end
