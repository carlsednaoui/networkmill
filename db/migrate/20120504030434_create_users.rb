class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.boolean :desktop_client
      t.integer :contact_intensity
      t.text :signature
      t.string :avatar
      t.boolean :unsubscribed, :default => false
      t.boolean :network_mode, :default => false
      t.boolean :first_time, :boolean, :default => true
      t.integer :tel_number

      t.timestamps
    end
  end
end
