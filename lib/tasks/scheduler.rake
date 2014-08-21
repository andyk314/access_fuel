desc "This task is called by the Heroku scheduler add-on"
task :update_events => :environment do
  puts "Updating events..."
  heroku rails runner "scripts/seeder.rb"
  puts "done."
end
