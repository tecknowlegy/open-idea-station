class AddEmailConfirmedColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_confirmed, :boolean, default: false
    add_column :users, :new_email, :string
    add_column :users, :locale, :string
  end
end
