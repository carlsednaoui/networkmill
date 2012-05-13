class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :user_id
      t.string :sent_to
      t.text :body
      t.string :contacts

      t.timestamps
    end
  end
end
