user = User.find_by_id(1)

def create_contact_bucket(user_id)
  @contact_bucket = Array.new
  contacts = Contact.find_all_by_user_id(user_id)
  contacts.each do |contact|
    @contact_bucket.push contact.id
  end
  return @contact_bucket
end

def get_contacts_from_contact_bucket(contact_bucket, contact_intensity)
  send_email(contact_bucket.first(contact_intensity))
  contact_bucket.shift(contact_intensity)
end

def contacts_left(contact_bucket)
  puts "These are the contacts left in your bucket"
  puts contact_bucket
end

def send_email(contacts_to_email)
  puts "Hey you, you should email these contacts:"
  puts contacts_to_email
end


create_contact_bucket(user)
get_contacts_from_contact_bucket(@contact_bucket, user.contact_intensity)
contacts_left(@contact_bucket)
