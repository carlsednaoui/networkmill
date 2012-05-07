class User < ActiveRecord::Base
  has_many :contacts

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :desktop_client, :contact_intensity, :email, :password, :password_confirmation, :remember_me
end
