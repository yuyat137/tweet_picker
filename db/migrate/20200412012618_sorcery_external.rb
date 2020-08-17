class SorceryExternal < ActiveRecord::Migration[5.2]
  def change
    create_table :authentications, options: 'DEFAULT CHARSET=utf8mb4' do |t|
      t.references :user, foreign_key: true
      t.string :provider, :uid, null: false

      t.timestamps              null: false
    end

    add_index :authentications, [:provider, :uid]
  end
end
