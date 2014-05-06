class AddGroupidToEvents < ActiveRecord::Migration
  def change
    add_column :events, :group_id, :integer
  end
end
