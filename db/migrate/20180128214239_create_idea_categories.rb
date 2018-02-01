class CreateIdeaCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :idea_categories do |t|

      t.timestamps
    end
  end
end
