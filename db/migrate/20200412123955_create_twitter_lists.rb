class CreateTwitterLists < ActiveRecord::Migration[5.2]
  def change
    create_table :twitter_lists do |t|
      t.belongs_to :user
      t.bigint :list_id, null: false
      t.string :list_name, null: false
      t.timestamps
    end
  end
end
