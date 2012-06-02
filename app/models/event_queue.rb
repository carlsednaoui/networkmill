class EventQueue < ActiveRecord::Base
	has_many :contacts
	belongs_to :user
  attr_accessible :email_sent, :user_id
end
