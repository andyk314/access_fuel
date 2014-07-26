class AddGaIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :ga_id, :string
  end
end
