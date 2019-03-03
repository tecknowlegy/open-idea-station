class AddImpressionToIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :impression, :integer
  end
end
