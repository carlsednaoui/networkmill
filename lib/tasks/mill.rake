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

  desc "Find all users with open queues, if the queue is more than 5 hrs old 
        send them a summary email and delete the queue."
  task :event_mode_check => :environment do
    puts ""
    User.where(:network_mode => true).each do |user| 
      user.destroy_queue_and_send_email if user.event_queue.created_at < Time.now - 5.hours
    end
    puts ""
  end
end