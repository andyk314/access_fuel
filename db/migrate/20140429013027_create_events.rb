class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :date
      t.time :time
      t.time :duration
      t.string :venue
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.integer :rsvp
      t.string :url

      t.timestamps
    end
  end
end
