class AddColumnToTwitterLists < ActiveRecord::Migration[5.2]
  def change
    add_column :twitter_lists, :access_id, :string, null:false
    add_index :twitter_lists, :access_id, unique: true
  end
end
