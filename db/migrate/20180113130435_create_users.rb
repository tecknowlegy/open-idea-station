class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.string :email, unique: true
      t.string :password_digest
      t.string :bio
      t.string :provider
      t.string :uid, unique: true
      t.string :picture

      t.timestamps
    end
  end
end
