class AddTelNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :tel_number, :integer
  end
end
