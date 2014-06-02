class AddMeetupidToEvents < ActiveRecord::Migration
  def change
    add_column :events, :meetup_id, :integer
  end
end
