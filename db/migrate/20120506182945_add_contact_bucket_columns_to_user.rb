class AddContactBucketColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :contact_bucket, :string
    add_column :users, :contacts_to_email, :string
    add_column :users, :contacts_emailed, :string
  end
end
