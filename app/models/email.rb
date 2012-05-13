class Email < ActiveRecord::Base
  attr_accessible :body, :contacts, :sent_to, :user_id
end
