# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Contact.create(:name => "seeb contact 1", :email => "seed1@mail.com", :user_id => User.first.id)
Contact.create(:name => "seeb contact 2", :email => "seed2@mail.com", :user_id => User.first.id)
Contact.create(:name => "seeb contact 3", :email => "seed3@mail.com", :user_id => User.first.id)
Contact.create(:name => "seeb contact 4", :email => "seed4@mail.com", :user_id => User.first.id)
Contact.create(:name => "seeb contact 5", :email => "seed5@mail.com", :user_id => User.first.id)
Contact.create(:name => "seeb contact 6", :email => "seed6@mail.com", :user_id => User.first.id)
