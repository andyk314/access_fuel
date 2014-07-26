class AddFormatToEvent < ActiveRecord::Migration
  def change
    add_column :events, :format, :string
  end
end
