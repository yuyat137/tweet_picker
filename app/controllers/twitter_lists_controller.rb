class TwitterListsController < ApplicationController
  def index
    # NOTE: current_user.twitter_listsとすると該当ユーザーの最新情報を取得できないため、下記の書き方をした
    @twitter_lists = User.find(current_user.id).twitter_lists
  end

  def show
    list = current_user.twitter_lists.find(params[:id])
    @tweets = current_user.twitter.list_timeline(list.list_id, count: 200).max_by(50, &:favorite_count)
  end

  def update_index
    # TODO: 今後、jsで作成したい
    current_user.update_twitter_lists
    redirect_to twitter_lists_path
  end
end
