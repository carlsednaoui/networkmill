class User < ActiveRecord::Base
  has_many :contacts
  attr_accessible :name, :email, :desktop_client, :contact_intensity, :password, :remember_me
  before_create :default_values

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def default_values
    self.contact_intensity = 3
    self.desktop_client = false
  end

  # picks n random contacts from the ones that are in rotation
  # if the list is depleted, resets the list. This results in
  # completely fluid random picks with no loss

  # There is a small bug here - if one is picked and the list is
  # reset, the same one can be added again, resulting in a double pick.
  # I'm working on this, but the solution is pretty complex : (

  def pick_random_contacts(n)
    result = []
    n.times do
      reset_list if contacts_in_rotation.count == 0
      contact = contacts_in_rotation.shuffle.first
      puts "============================"
      puts "added #{contact.id}"
      puts "============================"
      result << contact
      contact.update_attributes :state => :out
    end
    return result
  end

  def contacts_in_rotation
    contacts.select{ |c| c.in_rotation? }
  end

  def reset_list
    contacts.each { |c| c.state = :in }
  end

end
