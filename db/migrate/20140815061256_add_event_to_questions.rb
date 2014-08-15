class AddEventToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :event_id, :integer
  end
end
