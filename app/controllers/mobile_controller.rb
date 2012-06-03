class MobileController < ApplicationController
	def index
	  redirect_to mobile_preferences_path if current_user
	end

	def preferences
	end

	def add_contact
	end

end