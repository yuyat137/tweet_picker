class TweetsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  # TODO: enumを設定する方法がわからなかったので、分かり次第対応
  # NOTE: 0: 1日分のツイート、1: 200件、2: 400件、 3: 600件、 4: 800件
  attribute :read_tweets_num, :integer, default: 1
  # NOTE: 0: 総取得ツイートをお気に入り順、1: 1ユーザー1ツイート、　2: 1ユーザー2ツイート
  attribute :display_tweets_type, :integer
  # NOTE: 0: 50件、1: 100件、2: 150件
  attribute :display_tweets_num, :integer
  enum read_tweets_num: { hoge: 1, piyo: 2, fuga: 3 }

  def search(list, user)
    tweets = user.twitter.list_timeline(list.list_id, count: 200)

    (read_tweets_num - 1).times do
      tweets.concat(user.twitter.list_timeline(list.list_id, count: 200, max_id: tweets.last.id))
    end

    tweets.max_by(50, &:favorite_count)
  end
end

