class AddUserIdToViewers < ActiveRecord::Migration[5.1]
  def change
    add_reference :viewers, :user, foreign_key: true
  end
end
