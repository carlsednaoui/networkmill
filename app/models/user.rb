class User < ActiveRecord::Base
  has_many :contacts
  #removed attr_accesible for :password_confirmation
  attr_accessible :name, :email, :desktop_client, :contact_intensity, :password, :remember_me


  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def contacts_in_rotation
    contacts.select{ |c| c.in_rotation? }
  end

  def reset_list_if_needed
    if contacts_in_rotation.count < contact_intensity
      puts "resetting list"
      contacts.each { |c| c.state = :in }
      return true
    else
      puts "no need to reset"
      return false
    end
  end

end
