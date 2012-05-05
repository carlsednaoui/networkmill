class AddContactIntensityToUser < ActiveRecord::Migration
  def change
    add_column :users, :contact_intensity, :integer
  end
end
