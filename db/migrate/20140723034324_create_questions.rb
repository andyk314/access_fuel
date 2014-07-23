class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :poll
      t.integer :event
      t.integer :user

      t.timestamps
    end
  end
end
