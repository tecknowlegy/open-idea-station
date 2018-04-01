class AddColumnToIdea < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :is_archived, :boolean
  end
end
