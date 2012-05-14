class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :frequency
      t.integer :user_id
      t.string :state
      t.text :note

      t.timestamps
    end
  end
end
