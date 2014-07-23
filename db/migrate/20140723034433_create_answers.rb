class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :response
      t.integer :question
      t.integer :event
      t.integer :user

      t.timestamps
    end
  end
end
