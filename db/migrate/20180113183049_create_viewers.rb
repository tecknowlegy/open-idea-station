class CreateViewers < ActiveRecord::Migration[5.1]
  def change
    create_table :viewers do |t|
      t.datetime :time_viewed
      t.string :viewer_ip
      t.references :idea, foreign_key: true

      t.timestamps
    end
  end
end
