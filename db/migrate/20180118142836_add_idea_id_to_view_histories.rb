class AddIdeaIdToViewHistories < ActiveRecord::Migration[5.1]
  def change
    add_reference :view_histories, :idea, foreign_key: true
  end
end
