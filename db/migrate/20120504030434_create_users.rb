class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :desktop_client, :default => false

      t.timestamps
    end
  end
end
