class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => 'check_email'

  require 'csv'

  def export_contacts
      file = CSV.generate do |csv|
        csv << ["Name", "Email", "Note"]
        current_user.contacts.each do |c|
          csv << [c.name, c.email, c.note]
        end
      end
      send_data file, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=my_networkmill_contacts.csv" 
  end

  def index
    @users = User.find_all_by_id(current_user)
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    # If a user is changing his/ her password use "update with password", if they are
    # updating anything else use "update without password". password_fields checks
    # whether the :current_password field or the :password field is blank to serve
    # the right function

    password_fields = [params[:user][:current_password], params[:user][:password]]
    
    puts "==========================================="
    puts "Here we are logging in the controller wooop"
    puts "==========================================="

    # if password_fields.reject {|p| p.empty? }.empty?
    #   @success = true if @user.update_without_password(params[:user])
    # else
    #   if params[:user][:password].empty?
    #     @user.password_validation
    #   else
    #     @success = true if @user.update_with_password(params[:user])
    #   end
    # end

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

  def send_test_email
    UserMailer.new_contact_intro_email(current_user, current_user).deliver
    redirect_to preferences_path, :notice => "check your email for a special surprise ;)"
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end

  def check_email
    if User.find_by_email(params[:email])
      render :text => "true"
    else
      render :text => "false"
    end
  end

end
