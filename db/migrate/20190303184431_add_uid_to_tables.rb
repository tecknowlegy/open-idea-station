class AddUidToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :uid, :string
    add_column :comments, :uid, :string
    add_column :idea_categories, :uid, :string
    add_column :notifications, :uid, :string
    add_column :viewers, :uid, :string
  end
end
