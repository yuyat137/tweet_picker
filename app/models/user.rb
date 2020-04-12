class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def twitter_rest_client
    @twitter_rest_client ||= Twitter::REST::Client.new do |config|
      authentication = authentications.find_by(provider: 'twitter')
      config.consumer_key        = Rails.application.credentials.dig(:twitter, :api_key)
      config.consumer_secret     = Rails.application.credentials.dig(:twitter, :api_secret_key)
      config.access_token        = authentication.access_token
      config.access_token_secret = authentication.access_token_secret
    end
  end
end
