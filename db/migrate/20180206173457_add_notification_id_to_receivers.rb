class AddNotificationIdToReceivers < ActiveRecord::Migration[5.1]
  def change
    add_column :receivers, :notification_id, :integer
  end
end
