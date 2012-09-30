class Category < ActiveRecord::Base
  belongs_to :user
  has_many :contacts

  attr_accessible :intensity, :name, :user_id
  
  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :assign_default_contact_intensity
  def assign_default_contact_intensity
    self.intensity ||= 3
  end
end