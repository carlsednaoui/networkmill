class User < ActiveRecord::Base
  has_one :event_queue
  has_many :contacts
  has_many :emails
  has_many :social_networks
  has_many :feedback
  has_many :categories

  attr_accessible :name, :email, :unsubscribed, :desktop_client, :network_mode, :contact_intensity, :avatar, :password, :remember_me, :signature, :feedback, :social_networks_attributes, :first_time, :tel_number

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :social_networks, :allow_destroy => true

  mount_uploader :avatar, AvatarUploader

  # =================================
  # Validations
  # =================================

  # Validate that user has been added to the beta list
  before_validation :beta_invited?, :on => :create
  def beta_invited?
    unless BetaInvite.exists?(:email=>email)
      errors.add :email, "is not on our beta list"  
    end
  end

  validates :contact_intensity, :numericality => { :only_integer => true, :less_than_or_equal_to => :contact_validation}, :on => :update
  # Ensure that contact intensity is less than the # of contacts the user has. Default intensity = 3
  def contact_validation
    if contacts.count > $initial_contact_intensity
      contacts.count
    else
      $initial_contact_intensity
    end
  end

  # =================================
  # Default values & after create
  # =================================

  $initial_contact_intensity = 3

  # User defaul values once created with Devise
  before_create :user_default_values
  def user_default_values
    self.contact_intensity = $initial_contact_intensity
    self.desktop_client = 'false'
  end

  after_create :create_default_contact_category
  def create_default_contact_category
    self.categories.create(:name => "Uncategorized")
  end

  # Send user welcome email upon sign up
  after_create :send_welcome_mail if Rails.env != "test"
  def send_welcome_mail
    UserMailer.delay.send_welcome_email(self)
  end

  # =================================
  # Select random contacts
  # =================================

  # Picks n random contacts from those in rotation
  # - resets the list as soon as it's finished a rotation
  # - won't return the same contact more than once per list
  # - returns false if you ask for more contacts than the user has (to prevent doubling)
  def pick_random_contacts(n = contact_intensity)
    result = []
    return nil if n > contacts.count
    move_just_sent_to_out
    while result.count < n
      puts "********************************"
      puts contacts_in_rotation.inspect
      puts "********************************"
      puts contacts_in_rotation.count.inspect
      puts "********************************"
      puts contacts
      puts "********************************"

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

  # Get the contacts that are currently out of rotation
  def contacts_out
    contacts.select{ |c| c.state == "out" }
  end

  # Move the "just sent" contacts to "out"
  def move_just_sent_to_out
    contacts_just_sent.each do |c|
      c.update_attributes :state => "out"
    end
  end

  # Set contacts that were "out" to "in"
  def reset_list
    contacts.each do |c| 
      c.update_attributes :state => "in"
    end
  end

  # =================================
  # Mobile networking mode
  # =================================

  # This is triggered from the User Controller or the Rake task. This will destroy the
  # event queue and send a summary email of contacts the user just met
  def destroy_queue_and_send_email
    all_contacts = contacts.find_all_by_event_queue_id(event_queue.id)
    @contacts = []
    
    all_contacts.each do |c|
      @contacts << c.id
    end

    UserMailer.delay.send_network_mode_contact_summary(self, @contacts)
    update_attributes(:network_mode => false)
    EventQueue.find_by_user_id(self).destroy
  end
end
