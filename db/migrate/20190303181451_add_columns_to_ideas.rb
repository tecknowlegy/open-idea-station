class AddColumnsToIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :uid, :string
    add_column :ideas, :slug_name, :string
  end
end
