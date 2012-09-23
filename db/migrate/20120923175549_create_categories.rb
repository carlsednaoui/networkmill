class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.string :name
      t.integer :intensity

      t.timestamps
    end
  end
end
