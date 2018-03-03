class CreateIdeaCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :idea_categories, &:timestamps
  end
end
