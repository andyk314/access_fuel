class AddMeetupOrganizerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetup_organizer, :boolean, null: false, default: false
  end
end
