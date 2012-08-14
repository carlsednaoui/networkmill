class UserMailer < ActionMailer::Base
  default from: "\"NetworkMill\" <hi@networkmill.com>"

  #=========================================
  # Send welcome email to new user
  #=========================================
  def send_welcome_email(user)
    mail to: user.email, subject: "Sign Up Confirmation - Welcome to NetworkMill"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "welcome_email")
  end

  #=========================================
  # Run_the_mill method
  # Notify user if he/she has too few contacts 
  # This email is only sent once per user
  #=========================================
  def user_has_few_contacts(user)
    mail to: user.email, subject: "NetworkMill - Why Not Add Some Contacts?"
    Email.create(:user_id => user.id, :sent_to => user.email, :title => "user_has_few_contacts")
  end

  #=========================================
  # Run_the_mill method
  # Send random contacts based on user_contact_intensity
  #=========================================
  def send_random_contacts(user, contacts_id)
    @contacts = []

  	contacts_id.each do |c|
  		@contacts << Contact.find_by_id(c)
  	end

  	mail to: user.email, subject: "NetworkMill - Awesome People to Contact This Week"
    puts "sent email to #{user.email}!"

    Email.create(:user_id => user.id, :sent_to => user.email, :title => "send_random_contacts", :contacts => contacts_id.join(','))
  end

  #=========================================
  # Mobile app method
  # Send introduction email when user adds new contact from mobile if network_mode == true
  # Also used to send test email to current_user
  #=========================================
  def new_contact_intro_email(user, contact)
    if user.name.present?
      @name = user.name.titlecase
    else
      @name = user.email
    end

    @signature = user.signature
    @email = user.email

    mail to: contact.email, reply_to: @email, from: "\"#{@name}\" <#{@email}>", subject: "#{@name} wants to stay in touch with you!"
    Email.create(:user_id => user.id, :sent_to => contact.id, :title => "new_contact_intro_email", :contacts => contact.id)
  end

  #=========================================
  # Mobile app method
  # Send user a summary of the contacts added during a network_mode session
  #=========================================
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

  #=========================================
  # Send user feedback to hi@networkmill.com
  #=========================================
  def send_feedback_to_team(feedback)
    @message = feedback.message

    if feedback.user.present?
      @name = feedback.user.name if feedback.user.name.present?
      @email = feedback.user.email if feedback.user.email.present?
    end

    mail to: "hi@networkmill.com", subject: "Feedback for NetworkMill"
    Email.create(:sent_to => "hi@networkmill.com", :title => "send_feedback_to_team")
  end
  
end
