class AddGroupPhotoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :group_photo, :string
  end
end
