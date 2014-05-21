class AddEventDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_date, :datetime
  end
end
