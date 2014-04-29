class AddGroupToEvents < ActiveRecord::Migration
  def change
    add_column :events, :group, :string
  end
end
