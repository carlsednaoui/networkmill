# This file is called by the Heroku scheduler add-on
# https://devcenter.heroku.com/articles/scheduler

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
      user.destroy_queue_and_send_email if user.event_queue.created_at < Time.now - 1.minutes
    end
    puts ""
  end