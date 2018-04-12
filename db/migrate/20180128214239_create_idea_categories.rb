class CreateIdeaCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :idea_categories do |t|
      t.references :category, foreign_key: true
      t.references :idea, foreign_key: true

      t.timestamps
    end
  end
end
