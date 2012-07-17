class MobileController < ApplicationController
layout "mobile"
before_filter :authenticate_user!, :except => ['index', 'forgot_password']

  # If mobile user is in network mode, set index page to add_mobile_contact
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

    # If user is in network mode, add contact to user_event_queue and send "welcome" email to new contact
    if @contact.user.network_mode
      @contact.event_queue_id = @contact.user.event_queue.id
      UserMailer.delay.new_contact_intro_email(current_user, @contact)
    end

    @success = true if @contact.save
  end

  def update_mobile_user
    # =========++++========= TODO: ADD JS VALIDATION =========++++=========
    
    @user = current_user
    redirect_to add_mobile_contact_path if @user.update_without_password(params)

    # Create EventQueue if network_mode is on, else destroy EventQueue and send
      # a "summary" email to the @user if needed
      if @user.network_mode
        # Create an EventQueue only if the user has none
        EventQueue.create(:user_id => @user.id) unless @user.event_queue.present?
      else
        # Ensure that user has an open EventQueue and destroy it
        @user.destroy_queue_and_send_email if @user.event_queue.present?
      end
  end

  def forgot_password
  end

end