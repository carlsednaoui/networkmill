User.create(:name => "seed user", :email => "networkmill@gmail.com", :password => "ilovetonetwork")
@user = User.find_by_email("networkmill@gmail.com")


for c in (1..10)
  @contacts = @user.contacts.count + 1
  Contact.create(:name => "seed contact " + @contacts.to_s, :email => "seed" + @contacts.to_s + "@mail.com", :user_id => @user.id, :state => :in)
end

puts "---------------------------------------------------------------------"
puts "database seeded - login for example user is networkmill@gmail.com // ilovetonetwork"
puts "database seeded - created " + c.to_s + " contacts for example user" 
puts "---------------------------------------------------------------------"
