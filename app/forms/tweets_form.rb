class TweetsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include Enum

  attribute :read_tweets_num, :integer, default: 0
  attribute :display_tweets_type, :integer, default: 0
  attribute :display_tweets_num, :integer, default: 0

  enum read_tweets_num: { read_200: 0, read_400: 1, read_600: 2, read_800: 3, read_one_day: 4 }.freeze
  enum display_tweets_type: { all_tweets: 0, one_per_one: 1, two_per_one: 2 }.freeze
  enum display_tweets_num: { display_50: 0, display_100: 1, display_150: 2 }.freeze

  def search(list, user)
    tweets = user.twitter.list_timeline(list.list_id, count: 200)

    read_tweets_num_value.times do
      tweets.concat(user.twitter.list_timeline(list.list_id, count: 200, max_id: tweets.last.id))
    end

    tweets.max_by(50, &:favorite_count)
  end
end

