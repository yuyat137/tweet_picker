class AddIndexToTwitterLists < ActiveRecord::Migration[5.2]
  def change
    add_index :twitter_lists, [:user_id, :list_id], unique: true
  end
end
