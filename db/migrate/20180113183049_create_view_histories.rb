class CreateViewHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :view_histories do |t|
      t.datetime :time_viewed
      t.string :viewer_ip

      t.timestamps
    end
  end
end
