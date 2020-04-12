class Authentication < ApplicationRecord
  belongs_to :user
  attr_encrypted :access_token, key: Rails.application.credentials.encryption_key
  attr_encrypted :access_token_secret, key: Rails.application.credentials.encryption_key
end
