class HomeController < ApplicationController
  before_filter :require_current_user, :except => [:index]

  def index
  end

  def dashboard
    @user = current_user
  end
end
