class CreateEventQueues < ActiveRecord::Migration
  def change
    create_table :event_queues do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
