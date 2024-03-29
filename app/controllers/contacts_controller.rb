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

    if @contact.save
      redirect_to dashboard_path, :notice => "contact saved!"
    else
      # This should not ever happen
      # render 'edit'

      # Temporary fix by Carl
      redirect_to dashboard_path, :notice => "there was a problem saving your contact. make sure this contact doesn't already exist"
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      redirect_to dashboard_url, :notice => 'Contact was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to dashboard_path, :notice => "contact deleted"
  end

end
