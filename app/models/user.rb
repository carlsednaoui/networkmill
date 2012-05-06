class User < ActiveRecord::Base
  has_many :contacts

#using serialize so that buckets are saved as arrays in the DB
  serialize :contact_bucket
  serialize :contacts_to_email
  serialize :contacts_emailed

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end
end
