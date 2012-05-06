class ContactsController < ApplicationController
  before_filter :require_current_user
  before_filter :require_contact_belongs_to_current_user, :only => [:show, :edit, :update, :destroy]

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

    if @contact.save
      redirect_to contacts_url, notice: 'Contact was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to contacts_url, notice: 'Contact was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    redirect_to contacts_url
  end

  def require_contact_belongs_to_current_user
    @contact = current_user.contacts.find(params[:id])
  end
end
