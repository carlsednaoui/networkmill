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
    
    password_fields = [params[:user][:current_password], params[:user][:password]]
    
    if password_fields.reject {|p| p.empty? }.empty?
      @success = true if @user.update_without_password(params[:user])
    else
      if params[:user][:password].empty?
        @user.password_validation
      else
        @success = true if @user.update_with_password(params[:user])
      end
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end
end
