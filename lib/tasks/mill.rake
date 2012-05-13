def run_the_mill(user)
  if user.contact_intensity > user.contacts.count
    has_low_contacts(user)
  else
    contacts = user.pick_random_contacts
    UserMailer.send_contacts(user, contacts).deliver
  end
end

def has_low_contacts(user)
  threshold = 5
  if user.contacts.count < threshold
    puts "#{user.email} has low contacts. Sending an email now."
    UserMailer.low_contacts(user).deliver
  else
    puts "User contact_intensity > user.contacts.count. Need to add validation to ensure this doens't happen"
  end
end

namespace :mill do

  # task :single, :user, :needs => :environment do |t, args|
  #   puts ""
  #   run_the_mill User.find(args[:user])
  #   puts ""
  # end

  desc "picks random contacts and sends them to the user in an email"
  task :all => :environment do
    puts ""
    User.all.each { |user| run_the_mill(user) }
    puts ""
  end
end