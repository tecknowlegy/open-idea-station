class AddColumnToIdeaCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :idea_categories, :idea_id, :integer
    add_column :idea_categories, :category_id, :integer
  end
end
