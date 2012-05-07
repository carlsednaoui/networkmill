User.create(:name => "seed user", :email => "seed@user.com", :password => "password")
@user = User.find_by_email("seed@user.com")
Contact.create(:name => "seed contact 1", :email => "seed1@mail.com", :user_id => @user.id, :state => :in)
Contact.create(:name => "seed contact 2", :email => "seed2@mail.com", :user_id => @user.id, :state => :in)
Contact.create(:name => "seed contact 3", :email => "seed3@mail.com", :user_id => @user.id, :state => :in)
Contact.create(:name => "seed contact 4", :email => "seed4@mail.com", :user_id => @user.id, :state => :in)
Contact.create(:name => "seed contact 5", :email => "seed5@mail.com", :user_id => @user.id, :state => :in)
Contact.create(:name => "seed contact 6", :email => "seed6@mail.com", :user_id => @user.id, :state => :in)
puts "---------------------------------------------------------------------"
puts "database seeded - login for example user is seed@user.com // password"
puts "---------------------------------------------------------------------"
