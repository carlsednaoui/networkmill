class UserMailer < ActionMailer::Base
  default from: "networkmill@gmail.com"

  def send_welcome_email(user)
    mail to: user.email, subject: "Sign Up Confirmation - Welcome to NetworkMill"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "welcome_mail")
  end

  def user_has_few_contacts(user)
    mail to: user.email, subject: "NetworkMill - Why Not Add Some Contacts?"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "user_has_few_contacts")
  end

  def send_random_contacts(user, contacts_id)
    @contacts = []

  	contacts_id.each do |c|
  		@contacts << Contact.find_by_id(c)
  	end
  	mail to: user.email, subject: "NetworkMill - Awesome People to Contact This Week"
    puts "sent email to #{user.email}!"

    Email.create(:user_id => user.id, :sent_to => user.email, :title => "mill_mail", :contacts => contacts_id.join(','))
  end

  # ==> **Need to find a better name for this function && Finish the View for it - Carl
  def user_referral_via_new_contact(user, contact)
    if user.name.present?
      @name = user.name.titlecase
    else
      @name = user.email
    end

    @signature = user.signature
    @email = user.email

    mail to: contact.email, subject: "#{@name} wants to stay in touch with you!"
    Email.create(:user_id => user.id, :sent_to => contact.id, :title => "user_referral", :contacts => contact.id)
  end

  def send_network_mode_contact_summary(user, contacts_id)
    if user.name.present? 
      @name = "Hi there " + user.name.titlecase
    else 
      @name = "Hi there Captain"
    end

    @contacts = []

    contacts_id.each do |c|
      @contacts << Contact.find_by_id(c)
    end

    mail to: user.email, subject: "NetworkMill - Here is Your Networking Event Summary"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "networking_contact_summary")
  end
end
