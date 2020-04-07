class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.bigint :twitter_id, null: false
      t.string :access_token, null: false
      t.string :access_token_secret, null: false
      t.timestamps
    end
  end
end
