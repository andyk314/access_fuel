class ChangeMeetupidFromEvents < ActiveRecord::Migration
  def change
    change_column :events, :meetup_id, :string
  end
end