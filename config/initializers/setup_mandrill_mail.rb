# Set ActionMailer to send emails from Mandrill
ActionMailer::Base.smtp_settings = {  
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :user_name => "hi@networkmill.com",
  :password  => "3b72c0b2-21de-4017-b885-8951e84bc00f"
}