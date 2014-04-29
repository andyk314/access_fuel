class AddFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :time, :string
    add_column :events, :date, :string
    add_column :events, :duration, :string
  end
end
