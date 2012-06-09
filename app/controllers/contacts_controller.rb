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
    @contact.state = "in"   
    
    # If the user is in network mode, add contact to queue and send a "welcome"
    # email to the new contact
    if @contact.user.network_mode.eql? true
      puts "*******************************************"
      puts "in contacts controller, asking to create a contact in a queue"
      puts "*******************************************"
      @contact.event_queue_id = @contact.user.event_queue.id
      @success = true if @contact.save
      # UserMailer.user_referral_via_new_contact(current_user, @contact).deliver
    else
      # Save contact without adding it to EventQueue
      puts "*******************************************"
      puts "in contacts controller, asking to create a contact WITHOUT a queue"
      puts "*******************************************"
      @success = true if @contact.save
      # This will send an email to the contact if the user has "promote networkmill" on
      # if @contact.promote_networkmill == true
      #   UserMailer.user_referral_via_new_contact(current_user, @contact).deliver
      # end 
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to contacts_url, :notice => 'Contact was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to dashboard_path
  end
end
