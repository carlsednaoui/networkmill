class User < ActiveRecord::Base
  has_many :contacts
  attr_accessible :name, :email, :desktop_client, :contact_intensity, :password, :remember_me
  before_create :default_values

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # this should be removed and put in the controller. But later
  def default_values
    self.contact_intensity = 3
    self.desktop_client = 'false'
  end

  # Picks n random contacts from the ones that are in rotation
  # - resets the list as soon as it's finished a rotation
  # - won't return one contact more than once per list
  # - returns false if you ask for more contacts than the user has (to prevent doubling)

  def pick_random_contacts(n)
    result = []
    return false if n > contacts_in_rotation.count
    while result.count < n
      reset_list if contacts_in_rotation.count == 0
      contact = contacts_in_rotation.shuffle.first
      unless result.include?(contact)
        result << contact
        contact.update_attributes :state => :out
      end
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
