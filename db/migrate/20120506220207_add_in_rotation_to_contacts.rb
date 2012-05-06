class AddInRotationToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :in_rotation, :string
  end
end
