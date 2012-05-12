def has_low_contacts(user)
	if user.low_contacts?
	  puts "#{user.email} has low contacts. Sending an email now."
	  UserMailer.low_contacts(user).deliver
	end
end

namespace :low_contacts do
desc "find users with less than 5 contacts and reminds them to add more contacts in an email"
  task :all => :environment do
    puts ""
    User.all.each { |user| has_low_contacts(user) }
    puts ""
  end
end