class CreateIdeas < ActiveRecord::Migration[5.1]
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.string :url
      t.boolean :is_archived
      t.timestamp :published_at

      t.timestamps
    end
  end
end
