class CreateReceivers < ActiveRecord::Migration[5.1]
  def change
    create_table :receivers do |t|
      t.boolean :status

      t.timestamps
    end
  end
end
