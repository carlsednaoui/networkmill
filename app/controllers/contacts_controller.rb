class ContactsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @contacts = Contact.find_all_by_user_id(current_user)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.user = current_user

    # If the user is in network mode, add contact to queue and send a "welcome"
    # email to the new contact
    if @contact.user.network_mode
      @contact.event_queue_id = @contact.user.event_queue.id
     #  UserMailer.new_contact_intro_email(current_user, @contact).deliver
    end

    @contact.state = "in"
    
    if @contact.save
      redirect_to dashboard_path, :notice => "contact saved!"
    else
      render 'edit'
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to contacts_url, :notice => 'Contact was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to dashboard_path
  end
end
