class RenameColumnIsReadToReadAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :is_read, :read_at
  end
end

