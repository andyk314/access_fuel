class AddDataToAnswers < ActiveRecord::Migration
  def change
  	add_column :answers, :event_id, :integer
  	add_column :answers, :question_id, :integer
  end
end
