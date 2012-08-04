class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.text :note
      t.string :state
      t.string :avatar
      t.integer :event_queue_id

      t.timestamps
    end
  end
end
