class CustomFailure < Devise::FailureApp

# Override the default devise behavior so that if a user is not logged in and they
# hit www.networkmill.com/preferences (or any other url where log-in is required) 
# they get redirected to the root_url

  def redirect_url
     root_url
  end
end