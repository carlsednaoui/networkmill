class User < ActiveRecord::Base
  has_many :contacts
end
