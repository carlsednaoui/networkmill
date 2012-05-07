class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :email, :frequency, :state, :user_id

  validates_presence_of :email
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  #need to fix this
  validates_uniqueness_of :user && :email, :message => "already exists as a contact."

  scope :in_rotation, where(:state => :in)
  scope :last_week, where(:state => :just_used)

  def in_rotation?
    state == :in ? true : false
  end
end
