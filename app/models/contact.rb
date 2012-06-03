class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_queue
  mount_uploader :avatar, AvatarUploader
  attr_accessible :name, :email, :promote_networkmill, :frequency, :state, :user_id, :note, :avatar

  validates_presence_of :email, :name
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  validates_uniqueness_of :email, :scope => :user_id, :message => "already exists as a contact."

  # Not sure we need to use scopes for this
  #  scope :in_rotation, where (:state => :in)
  #  scope :last_week, where(:state => :just_used)

  def in_rotation?
    state == "in" ? true : false
  end
end
