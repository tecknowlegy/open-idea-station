class RenameColumnTimeViewedToViewedAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :viewers, :time_viewed, :viewed_at
  end
end
