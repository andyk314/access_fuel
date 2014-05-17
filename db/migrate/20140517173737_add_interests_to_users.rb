class AddInterestsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :interest, :string, array:true
  end
end
