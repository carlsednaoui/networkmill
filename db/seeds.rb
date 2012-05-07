# You first need to create a user
Contact.create(:name => "seed contact 1", :email => "seed1@mail.com", :user_id => User.first.id, :state => :in)
Contact.create(:name => "seed contact 2", :email => "seed2@mail.com", :user_id => User.first.id, :state => :in)
Contact.create(:name => "seed contact 3", :email => "seed3@mail.com", :user_id => User.first.id, :state => :in)
Contact.create(:name => "seed contact 4", :email => "seed4@mail.com", :user_id => User.first.id, :state => :in)
Contact.create(:name => "seed contact 5", :email => "seed5@mail.com", :user_id => User.first.id, :state => :in)
Contact.create(:name => "seed contact 6", :email => "seed6@mail.com", :user_id => User.first.id, :state => :in)
