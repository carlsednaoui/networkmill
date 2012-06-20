class MobileController < ApplicationController
layout "mobile"

	# If mobile user is in networkmode, the index page will be add_mobile_contact
	def index
		if current_user && current_user.network_mode == true
			redirect_to add_mobile_contact_path
	  elsif current_user
			redirect_to mobile_preferences_path
		end
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