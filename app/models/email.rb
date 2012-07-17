class Email < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :body, :contacts, :sent_to, :user_id
end