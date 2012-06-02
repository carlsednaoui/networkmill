User.create(:name => "seed user 1", :email => "networkmill@gmail.com", :password => "network")
User.create(:name => "seed user 2", :email => "network.mill@gmail.com", :password => "network")
User.create(:name => "seed user 3", :email => "net.workmill@gmail.com", :password => "network")

@user1 = User.find_by_email("networkmill@gmail.com")
@user2 = User.find_by_email("network.mill@gmail.com")

for c in (1..10)
  @contacts1 = @user1.contacts.count + 1
  Contact.create(:name => "seed contact " + @contacts1.to_s, :email => "seed" + @contacts1.to_s + "@mail.com", :user_id => @user1.id, :state => "in")
end

for c in (1..3)
  @contacts2 = @user2.contacts.count + 1
  Contact.create(:name => "seed contact " + @contacts2.to_s, :email => "seed" + @contacts2.to_s + "@mail.com", :user_id => @user2.id, :state => "in")
end

puts "---------------------------------------------------------------------"
puts "database seeded - created 3 users"
puts "database seeded - login emails are: networkmill@gmail.com // network.mill@gmail.com // net.workmill@gmail.com"
puts "database seeded - all passwords are network"
puts "database seeded - user 1 has 10 contacts // user 2 has 3 contacts"
puts "---------------------------------------------------------------------"
