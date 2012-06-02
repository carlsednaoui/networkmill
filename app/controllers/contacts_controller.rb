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
    # if @contact.promote_networkmill == true
    #   UserMailer.user_referral_via_new_contact(current_user, @contact).deliver
    # end

    if @contact.user.network_mode == true
      puts "*!*!*!*!*!*!*!*!!*********************aaaaa*********************!*!*!*!*!*!*!*!*!*!*"
        @contact.user.add_contact_to_networking_event_queu
      puts "*!*!*!*!*!*!*!*!!*********************aaaaa*********************!*!*!*!*!*!*!*!*!*!*"
    end

    if @contact.save
      redirect_to contacts_url, :notice => 'Contact was successfully created.'
    else
      render action: "new" 
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

    redirect_to contacts_url
  end
end
