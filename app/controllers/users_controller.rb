class UsersController < ApplicationController
  before_filter :require_current_user
  before_filter :user_is_current_user, :only => [:show, :edit, :update, :destroy]

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
      redirect_to dashboard_path, notice: 'User was successfully updated.'
    else
      render action: "edit", notice: 'Saved failed'
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end

  def user_is_current_user
    unless current_user == User.find(session[:user_id])
      flash[:error] = "You do not have access to this data."
      redirect_to "/"
    end
  end
end
