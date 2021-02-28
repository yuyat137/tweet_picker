class TweetsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Enum

  attribute :read_tweets_num, :integer, default: 0
  attribute :display_tweets_type, :integer, default: 0
  attribute :display_tweets_num, :integer, default: 0

  enum read_tweets_num: { read_200: 0, read_400: 1, read_600: 2, read_800: 3 }.freeze
  enum display_tweets_type: { all_tweets: 0, one_per_one: 1, two_per_one: 2 }.freeze
  enum display_tweets_num: { display_50: 0, display_100: 1, display_150: 2 }.freeze

  def search(list, user)
    tweets = initial_load(list, user)
    return if tweets.blank?

    read_tweets_num_value.times do
      old_tweet = tweets.min_by(&:created_at)
      tweets.concat(user.twitter.list_timeline(list.list_id, count: 200, max_id: old_tweet.id, tweet_mode: 'extended'))
    end

    oldest_tweet_time = tweets.min_by(&:created_at).created_at.in_time_zone.to_s(:datetime_jp)

    tweets.select! { |x| x.retweet? == false }

    if display_tweets_type != :all_tweets
      tweets = filter_tweets_by_display_type(tweets)
    end

    [tweets.max_by((display_tweets_num_value + 1) * 50, &:favorite_count), oldest_tweet_time]
  end

  private

  def initial_load(list, user)
    # NOTE: 恐らくtwitter側(もしくはgem)の問題で、1回目でツイートを取得できないことがあり、それに対応したメソッド
    tweets = []
    3.times do
      tweets = user.twitter.list_timeline(list.list_id, count: 200, tweet_mode: 'extended')
      break if tweets.length > 30

      tweets = []
    end
    tweets
  end

  def filter_tweets_by_display_type(tweets)
    tweets_per_user = {}
    tweets.each do |tweet|
      if tweets_per_user.include?(tweet.user.id)
        tweets_per_user[tweet.user.id].push(tweet)
      else
        tweets_per_user[tweet.user.id] = [tweet]
      end
    end
    tweets = []
    tweets_per_user.each do |user_id, _|
      tweets.concat(tweets_per_user[user_id].max_by(display_tweets_type_value, &:favorite_count))
    end
    tweets
  end
end
