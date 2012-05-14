class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :desktop_client
      t.integer :contact_intensity
      t.text :signature
      t.boolean :unsubscribed, :default => false

      t.timestamps
    end
  end
end
