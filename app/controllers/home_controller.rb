class HomeController < ApplicationController
  before_filter :require_current_user, :except => [:index]

  def index
  end

  def dashboard
  end
end
