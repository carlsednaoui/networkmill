class SocialNetwork < ActiveRecord::Base
  belongs_to :user
  attr_accessible :link, :name, :user_id
end
