desc "This task is called by the Heroku scheduler add-on"
task :update_events => :environment do
  puts "Updating events..."
  rails r "scripts/seeder.rb"
  puts "done."
end
