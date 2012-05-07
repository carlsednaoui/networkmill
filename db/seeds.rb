User.create(:name => "seed user", :email => "seed@user.com", :password => "password")
@user = User.find_by_email("seed@user.com")


for c in (1..10)
  @contacts = @user.contacts.count + 1
  Contact.create(:name => "seed contact " + @contacts.to_s, :email => "seed" + @contacts.to_s + "@mail.com", :user_id => @user.id, :state => :in)
end

puts "---------------------------------------------------------------------"
puts "database seeded - login for example user is seed@user.com // password"
puts "database seeded - created " + c.to_s + " contacts for example user" 
puts "---------------------------------------------------------------------"
