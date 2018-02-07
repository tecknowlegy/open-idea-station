class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :receiver_id
      t.integer :actor_id
      t.string :action
      t.datetime :read_at
      t.integer :notifiable_id
      t.string :notifiable_type
      
      t.timestamps
    end
  end
end
