user = User.find_by_id(1)

def create_contact_bucket(user)
  @contact_bucket = []

  contacts = Contact.find_all_by_user_id(user.id)
  contacts.each do |contact|
    @contact_bucket.push contact.id
  end

  user.contact_bucket = @contact_bucket
  user.contacts_emailed = []
  user.contacts_to_email = []
  user.save!
end

def get_contacts_to_email(user)
  if user.contact_bucket.count < user.contact_intensity
    create_contact_bucket(user)
  end
  user_contact_bucket = user.contact_bucket

  contacts_to_email = user_contact_bucket.first(user.contact_intensity)
  user.contacts_to_email = contacts_to_email
  user.contacts_emailed.push contacts_to_email
  user_contact_bucket.shift(user.contact_intensity)
  user.save!
end

def contacts_emailed(user)
  puts "These are the contacts we've suggested you email"
  puts user.contacts_emailed
end

def send_email(user)
  puts "Hey you, you should email these contacts:"
  puts user.contacts_to_email
end


#create_contact_bucket(user)
get_contacts_to_email(user)
send_email(user)
contacts_emailed(user)
puts "**This is what is left in your contact bucket"
puts user.contact_bucket
