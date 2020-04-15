class TwitterListsController < ApplicationController
  def index
    @twitter_lists = current_user.twitter_lists
  end

  def show
    list = current_user.twitter_lists.find(params[:id])
    @tweets = current_user.twitter.list_timeline(list.list_id, count: 200).max_by(50, &:favorite_count)
  end

  def update_index
    # TODO: 今後、できればjsで作成したい
    current_user.update_twitter_lists
    redirect_to twitter_lists_path
  end
end
