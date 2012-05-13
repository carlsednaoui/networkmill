class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :email, :frequency, :state, :user_id, :note

  validates_presence_of :email
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  validates_uniqueness_of :email, :scope => :user_id, :message => "already exists as a contact."

  # Not sure we need to use scopes for this
  #  scope :in_rotation, where (:state => :in)
  #  scope :last_week, where(:state => :just_used)

  def in_rotation?
    state == "in" ? true : false
  end
end
