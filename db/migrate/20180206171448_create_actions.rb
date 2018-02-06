class CreateActions < ActiveRecord::Migration[5.1]
  def change
    create_table :actions do |t|
      t.string :type
      t.string :priority
      t.text :message

      t.timestamps
    end
  end
end
