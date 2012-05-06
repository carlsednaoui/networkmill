user = User.find_by_id(1)

def create_contact_bucket(user)
  @contact_bucket = []

  contacts = Contact.find_all_by_user_id(user.id)
  contacts.each do |contact|
    @contact_bucket.push contact.id
  end

  user.contact_bucket = @contact_bucket
  user.save!
end

def get_contacts_to_email(user)
  user_contact_bucket = user.contact_bucket

  user.contacts_to_email = user_contact_bucket.first(user.contact_intensity)
  user_contact_bucket.shift(user.contact_intensity)
  user.save!
end

def contacts_left(user_id)
  puts "These are the contacts left in your bucket"
  puts User.find_by_id(user_id).contact_bucket
end

def send_email(user)
  puts "Hey you, you should email these contacts:"
  puts user.contacts_to_email
end


create_contact_bucket(user)
get_contacts_to_email(user)
send_email(user)
#contacts_left(user.id)
