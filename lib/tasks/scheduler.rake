# Used for the Heroku scheduler add-on
# https://devcenter.heroku.com/articles/scheduler

def run_the_mill(user)
  if user.contact_intensity > user.contacts.count
    puts "#{user.email} has low contacts. Sending an email now."
    puts "we're already contacted #{user.email}" if user.emails.find_by_title("user_has_few_contacts").present?
    UserMailer.user_has_few_contacts(user).deliver unless user.emails.find_by_title("user_has_few_contacts").present?
  else
    contacts = user.pick_random_contacts
    UserMailer.send_random_contacts(user, contacts).deliver
  end
end


desc "picks random contacts and sends them to the user in an email"
  task :all => :environment do
    # Run the mill on Tuesdays
    if Time.now.tuesday?
      puts ""
      User.where(:unsubscribed => false).each { |user| run_the_mill(user) }
      puts ""
    end
  end

desc "test the weekly email"
  task :tits => :environment do
    User.where(:unsubscribed => false).each { |user| run_the_mill(user) }
  end

desc "Find all users with open queues, if the queue is more than 5 hrs old send them a summary email and delete the queue."
  task :event_mode_check => :environment do
    puts ""
    User.where(:network_mode => true).each do |user| 
      user.destroy_queue_and_send_email if user.event_queue.created_at < Time.now - 1.minutes
    end
    puts ""
  end

  # ========================================================
  # Code below is used for heroku dev/ testing purposes
  # ========================================================
  task :now => :environment do
    # Used for Heroku dev purposes
    puts ""
    User.where(:unsubscribed => false).each { |user| run_the_mill(user) }
    puts ""
  end