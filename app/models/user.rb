class User < ActiveRecord::Base
  has_many :contacts
  has_many :emails
  attr_accessible :name, :email, :desktop_client, :contact_intensity, :password, :remember_me
  before_create :default_values

  #This will send users a welcome email when they sign up
  # after_create :send_welcome_mail

  def send_welcome_mail
    UserMailer.welcome_email(self.email).deliver
  end

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
  # Need to relook at this, but everything seems to work
  def pick_random_contacts(n = contact_intensity)
    result = []
    return nil if n > contacts.count
    move_just_sent_to_out
    while result.count < n
      reset_list if contacts_in_rotation.count == 0
      contact = contacts_in_rotation.shuffle.first
      unless result.include?(contact)
        result << contact
        contact.update_attributes :state => "just_sent"
      end
    end
    return result
  end

  def contacts_in_rotation
    contacts.select{ |c| c.state == "in" }
  end

  def contacts_just_sent
    contacts.select{ |c| c.state == "just_sent" }
  end

  def move_just_sent_to_out
    just_sent = contacts_just_sent
    just_sent.each do |c|
      c.update_attributes :state => "out"
    end
  end

  def reset_list
    contacts.each do |c| 
      c.update_attributes :state => "in"
    end
  end

  def low_contacts?
    threshold = 5
    return true if contacts.count < threshold
  end
end
