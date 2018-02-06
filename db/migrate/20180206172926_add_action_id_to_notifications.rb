class AddActionIdToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :action_id, :integer, null: false
  end
end
