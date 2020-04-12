class AddColumnToAuthentication < ActiveRecord::Migration[5.2]
  def change
    add_column :authentications, :encrypted_access_token, :string
    add_column :authentications, :encrypted_access_token_iv, :string
    add_column :authentications, :encrypted_access_token_secret, :string
    add_column :authentications, :encrypted_access_token_secret_iv, :string
  end
end
