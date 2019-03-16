class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_changed_at, :datetime
    add_column :users, :admin, :boolean
  end
end
