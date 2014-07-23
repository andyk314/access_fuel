class AddAnswerIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :answer_id, :integer
  end
end
