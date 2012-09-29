class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_queue
  belongs_to :category
  mount_uploader :avatar, AvatarUploader
  attr_accessible :name, :email, :frequency, :state, :user_id, :note, :avatar, :event_queue_id, :category_id

  before_save :asign_default_contact_category
  def asign_default_contact_category
    self.category ||= self.user.categories.first
  end

  validates_presence_of :email, :name
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  validates_uniqueness_of :email, :scope => :user_id, :message => "already exists as a contact."

end