class UserMailer < ActionMailer::Base
  default from: "networkmill@gmail.com"

  def send_welcome_email(user)
    @greeting = "Hi"

    mail to: user.email, subject: "Sign Up Confirmation - Welcome to NetworkMill"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "welcome_mail")
  end

  def user_has_few_contacts(user)
    mail to: user.email, subject: "Hey, you need to add contacts"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "low_contacts_mail")
  end

  def send_random_contacts(user, contacts_id)
    @contacts = []

  	contacts_id.each do |c|
  		@contacts << Contact.find_by_id(c)
  	end
  	mail to: user.email, subject: "Awesome People to Contact This Week"
    puts "sent email to #{user.email}!"

    Email.create(:user_id => user.id, :sent_to => user.email, :title => "mill_mail", :contacts => contacts_id.join(','))
  end

  def user_referral_via_new_contact(user, contact)
    @user_email = user.email
    mail to: contact.email, subject: "#{user.email} wants to stay in touch with you!"
    Email.create(:user_id => user.id, :sent_to => contact.id, :title => "user_added_contact", :contacts => contact.id)
  end

  def send_network_mode_contacts(user, contacts_id)
    @greeting = "What's cooking good looking?"
    @contacts = []

    contacts_id.each do |c|
      @contacts << Contact.find_by_id(c)
    end

    mail to: user.email, subject: "Here is Your Networking Event Summary"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "networking_event_summary")
  end
end
