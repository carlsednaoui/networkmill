class CreateBetaInvites < ActiveRecord::Migration
  def change
    create_table :beta_invites do |t|
      t.string :email

      t.timestamps
    end
  end
end
