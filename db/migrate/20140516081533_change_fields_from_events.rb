class ChangeFieldsFromEvents < ActiveRecord::Migration
  def change
    change_column :events, :group_photo, :text
  end
end
