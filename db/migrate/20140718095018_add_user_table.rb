class AddUserTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email
      t.string :password_digest
    end
  end
end
