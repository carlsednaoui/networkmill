class Category < ActiveRecord::Base
  belongs_to :user
  has_many :contacts
  attr_accessible :intensity, :name, :user_id
end
