class UsersController < ApplicationController
  before_filter :authenticate_user!

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
    if @user.update_attributes(params[:user])
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to dashboard_path, :notice => 'Your settings were successfully updated.'
    else
      render "edit", :notice => 'Saved failed'
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end
end
