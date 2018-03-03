class AddIdeaIdToViewers < ActiveRecord::Migration[5.1]
  def change
    add_reference :viewers, :idea, foreign_key: true
  end
end
