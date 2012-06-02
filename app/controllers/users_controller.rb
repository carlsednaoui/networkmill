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
      @success = true
      # sign_in @user, :bypass => true
    else
      # render "edit", :notice => 'Saved failed'
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end
end
