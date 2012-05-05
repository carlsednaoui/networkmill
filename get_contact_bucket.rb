user = User.find_by_id(1)

@contact_bucket = Array.new
def create_contact_bucket(user_id)
   contacts = Contact.find_all_by_user_id(user_id)
   contacts.each do |contact|
	@contact_bucket.push contact.id
   end
end

def get_contacts_from_contact_bucket(contact_bucket, contact_intensity)
  @contact_bucket = contact_bucket
  puts "contacts to email:"
  to_email = @contact_bucket.first(contact_intensity)
  puts to_email
  @contact_bucket.shift(contact_intensity)
  puts "contacts left:"
  puts @contact_bucket.inspect
end


create_contact_bucket(user)
get_contacts_from_contact_bucket(@contact_bucket, user.contact_intensity)
