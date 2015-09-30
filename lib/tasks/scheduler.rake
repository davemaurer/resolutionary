desc "Heroku scheduler task to remind users of resolutions"

task :send_notification => :environment do
  Reminder.new.remind
  puts "message sent"
end
