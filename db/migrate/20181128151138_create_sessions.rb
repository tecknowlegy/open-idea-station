class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table   :sessions do |t|
      t.references :user, index: true
      t.boolean    :active
      t.string     :device_platform
      t.datetime   :expires_at, null: false
      t.string     :ip_address
      t.string     :location
      t.string     :token
      t.string     :user_agent
      t.string     :uid

      t.timestamps
    end
  end
end
