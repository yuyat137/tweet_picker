class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  has_many :twitter_lists, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def twitter
    @twitter ||= Twitter::REST::Client.new do |config|
      authentication = authentications.find_by(provider: 'twitter')
      config.consumer_key        = Rails.application.credentials.dig(:twitter, :api_key)
      config.consumer_secret     = Rails.application.credentials.dig(:twitter, :api_secret_key)
      config.access_token        = authentication.access_token
      config.access_token_secret = authentication.access_token_secret
    end
  end

  def update_twitter_lists
    temp_lists = twitter.lists
    new_twitter_lists = []
    temp_lists.each do |list|
      new_twitter_lists << TwitterList.new(list_id: list.id,
                                           list_name: list.name,
                                           access_id: SecureRandom.base58(TwitterList::ACCESS_ID_MAX_LENGTH),
                                           profile_image_url: list.user.profile_image_url.to_s,
                                           mode: list.mode,
                                           name: list.user.name,
                                           screen_name: list.user.screen_name)
    end
    twitter_lists.destroy_all
    twitter_lists.import new_twitter_lists
  end
end
