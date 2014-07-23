class AddAnswerIdToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :answer_id, :integer
  end
end
