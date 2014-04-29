class RemoveDurationFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :duration, :string
  end
end
