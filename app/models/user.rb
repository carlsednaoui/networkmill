class User < ActiveRecord::Base
  has_many :contacts
  has_many :emails
  validates :contact_intensity, :numericality => { :only_integer => true, :less_than_or_equal_to => :contact_validation}, :on => :update
  attr_accessible :name, :email, :unsubscribed, :desktop_client, :network_mode, :contact_intensity, :password, :remember_me
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Validation to ensure that contact intensity is not greater than the # of contacts. Default intensity = 3
  def contact_validation
    if contacts.count > 3
      contacts.count
    else
      3
    end
  end

  # Add default values to a User when it is created with Devise
  before_create :default_values

  def default_values
    self.contact_intensity = 3
    self.desktop_client = 'false'
  end

  # Send users a welcome email when they sign up
  # after_create :send_welcome_mail

  def send_welcome_mail
    UserMailer.send_welcome_email(self).deliver
  end

  # Picks n random contacts from the ones that are in rotation
  # - resets the list as soon as it's finished a rotation
  # - won't return one contact more than once per list
  # - returns false if you ask for more contacts than the user has (to prevent doubling)
  # Need to relook at this, but everything seems to work
  def deprecated_pick_random_contacts(n = contact_intensity)
    result = []
    return nil if n > contacts.count
    move_just_sent_to_out
    while result.count < n
      reset_list if contacts_in_rotation.count == 0
      contact = contacts_in_rotation.shuffle.first
      unless result.include?(contact)
      	result << contact.id
      	contact.update_attributes :state => "just_sent"
      end
    end
    return result
  end

  def pick_random_contacts(n = contact_intensity)
    result = []
    move_just_sent_to_out
    while result.count < n
      reset_list if contacts_in_rotation.count == 0
      contact = contacts_in_rotation.shuffle.first
      unless result.include?(contact)
      	result << contact.id
      	contact.update_attributes :state => "just_sent"
      end
    end
    return result
  end

  # Get the contacts that are currently in rotation
  def contacts_in_rotation
    contacts.select{ |c| c.state == "in" }
  end

  # Get the contacts that were suggested in the last email
  def contacts_just_sent
    contacts.select{ |c| c.state == "just_sent" }
  end

  # Move the "just sent" contacts to "out"
  def move_just_sent_to_out
    just_sent = contacts_just_sent
    just_sent.each do |c|
      c.update_attributes :state => "out"
    end
  end

  # Set all User.contacts in rotation
  def reset_list
    contacts.each do |c| 
      c.update_attributes :state => "in"
    end
  end

  # Create a networking event contact queu. At the end of the event (current set to 5 hrs), 
  # the User will get an email containing the contact info of everyone he/ she met
  def add_contact_to_networking_event_queu
    # create an array of contact id's
    # at end of 5 hrs send User an eamil with all of the info
    # set the "promote networkmill to true"
    puts "add_contact_to_networking_event_queu"
  end
end
