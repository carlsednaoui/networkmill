class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:check_email, :update]

  # Allow user to export contacts in csv
  require 'csv'
  def export_contacts
      file = CSV.generate do |csv|
        csv << ["Name", "Email", "Category", "Note"]
        current_user.contacts.each do |c|
          csv << [c.name, c.email, Category.find_by_id(c.category_id).name, c.note]
        end
      end
      send_data file, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=my_networkmill_contacts.csv" 
  end

  #Allow user to import contacts in csv
  def import_contacts
    # Get the csv file from the params
    file = params[:csv_file]

    if file.present? && file.content_type == "text/csv"
      # Loop through each row of the csv file
      CSV.foreach(file.tempfile, :headers => true) do |row|
        # Find or create the cotact category for the current_user  
        category = current_user.categories.find_or_create_by_name(row[2])
        
        # Create contacts for the current user, csv columns are found with row[position]
        @new_contact = Contact.create(user_id: current_user.id, name: row[0], email: row[1], category_id: category.id,note: row[3])
      end

      # Check that the last row was saved, note: this needs to be revised to avoid edge cases
      if @new_contact.save
        redirect_to preferences_path, notice: "contacts saved"
      else
        redirect_to preferences_path, notice: "ohh no, there was an error - are you sure these are new contacts?"
      end
    else
      redirect_to preferences_path, :notice => "hmm, you need a csv file for this to work"
    end 
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
  
    # TODO: before deploying, we should test this to make sure authentication is working

    # if user is resetting password, reset the password and redirect to root
    if params[:user][:reset_password_token]
      User.reset_password_by_token(params[:user])
      redirect_to root_url, notice: 'password reset successfully!'
    # if user is updating their preferences, make sure to authenticate
    else
      authenticate_user!
      @user = current_user
      password_fields = [params[:user][:current_password], params[:user][:password]]
      # if they are updating anything except the password, no need to pass authenticate
      if password_fields.reject {|p| p.empty? }.empty?
        @user.update_without_password(params[:user])
      # if they are trying to update their password, make sure it's right
      else
        @user.update_with_password(params[:user])
      end
      redirect_to dashboard_path, :notice => "sweet, your preferences have been updated!"
    end

  end

  # Allow user to send itself a test email from the preference panel
  def send_test_email
    # Send mail without delayed job:
    # UserMailer.new_contact_intro_email(current_user, current_user).deliver
    # Send mail with delayed job (to get delayed_job working in development run $rake jobs:work)
    UserMailer.delay.new_contact_intro_email(current_user, current_user)
    redirect_to preferences_path, :notice => "check your email for a special surprise ;)"
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end

  def check_email
    if User.find_by_email(params[:email])
      render :text => "registered"
    elsif BetaInvite.find_by_email(params[:email]).nil?
      render :text => "not_beta"
    else
      render :text => "false"
    end
  end

end
