class MobileController < ApplicationController
layout "mobile"
before_filter :authenticate_user!, :except => ['index', 'forgot_password']

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
	   	
	   	# Uncomment before going live
	    # UserMailer.new_contact_intro_email(current_user, @contact).deliver
	  end
	end

	def update_mobile_user
		# ============== ADD JS VALIDATION
		# ============== ADD JS VALIDATION
		# ============== ADD JS VALIDATION

		@user = current_user
		redirect_to add_mobile_contact_path if @user.update_without_password(params)

		# Create EventQueue if network_mode is on, else destroy EventQueue and send
	    # a "summary" email to the @user if needed
	    if @user.network_mode
	      # Only create a Queue if the user has no queue
	      EventQueue.create(:user_id => @user.id) unless @user.event_queue.present?
	    else
	      # Ensure that a user really has an open event_queue
	      @user.destroy_queue_and_send_email if @user.event_queue.present?
	    end
	end

	def forgot_password
	end

end