def run_the_mill(user)
  if user.contact_intensity > user.contacts.count
    low_contacts(user)
  else
    contacts = user.pick_random_contacts
    UserMailer.send_random_contacts(user, contacts).deliver
  end
end

def low_contacts(user)
  puts "#{user.email} has low contacts. Sending an email now."
  UserMailer.user_has_few_contacts(user).deliver
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
    User.where(:unsubscribed => false).each { |user| run_the_mill(user) }
    puts ""
  end
end
