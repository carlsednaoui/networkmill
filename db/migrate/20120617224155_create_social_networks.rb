class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.integer :user_id
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
