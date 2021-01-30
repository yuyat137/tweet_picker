class Authentication < ApplicationRecord
  belongs_to :user
  attr_encrypted :access_token, key: Rails.application.credentials.encryption_key
  attr_encrypted :access_token_secret, key: Rails.application.credentials.encryption_key

  def self.twitter_access_token(user)
    if user.email == 'guest'
      Rails.application.credentials.dig(:guest, :access_token)
    else
      authentication = user.authentications.find_by(provider: 'twitter')
      authentication.access_token
    end
  end

  def self.twitter_access_token_secret(user)
    if user.email == 'guest'
      Rails.application.credentials.dig(:guest, :access_token_secret)
    else
      authentication = user.authentications.find_by(provider: 'twitter')
      authentication.access_token_secret
    end
  end
end
