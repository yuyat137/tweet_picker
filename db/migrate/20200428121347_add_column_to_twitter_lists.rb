class AddColumnToTwitterLists < ActiveRecord::Migration[5.2]
  def change
    add_column :twitter_lists, :access_id, :string, null:false
    add_column :twitter_lists, :profile_image_url, :string
    add_column :twitter_lists, :mode, :string
    add_column :twitter_lists, :screen_name, :string
    add_index :twitter_lists, :access_id, unique: true
  end
end
