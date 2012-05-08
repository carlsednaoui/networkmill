class UserMailer < ActionMailer::Base
  default from: "networkmill@gmail.com"

  def welcome_email(email)
    @greeting = "Hi"

    mail to: email, subject: "Sign Up Confirmation - Welcome to NetworkMill"
  end
end
