class MobileController < ApplicationController
layout "mobile"

	def index
	  redirect_to mobile_preferences_path if current_user
	end

	def preferences
		@user = current_user
	end

	def add_contact
		@contact = Contact.new
	end

	def create_contact
		@contact = Contact.new(params)
    @contact.user = current_user

    @contact.state = "in"
    
    if @contact.save
	    @success = true
	    # If the user is in network mode, add contact to user event queu
	    @contact.event_queue_id = @contact.user.event_queue.id if @contact.user.network_mode
	   
	    UserMailer.new_contact_intro_email(current_user, @contact).deliver
	  end
	end

end