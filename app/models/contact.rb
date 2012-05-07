class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :email, :frequency, :state
  
  validates_presence_of :email
  validates_format_of :email, :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i

  # states = :in, :out, :just_used
  scope :in_rotation, where(:state => :in)
  scope :last_week, where(:state => :just_used)

  def in_rotation?
    state == :in ? true : false
  end

  # first run a check to see if we need to reset the list
  # @last_week = the :just_used ones, then set them to :out
  # pick randoms from :in, add them to the email, set them to :just_used

end
