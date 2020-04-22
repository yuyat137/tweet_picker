class TwitterListsController < ApplicationController
  def index
    @twitter_lists = current_user.twitter_lists
  end

  def show
    list = current_user.twitter_lists.find_by(access_id: params[:access_id])
    if list
      @tweets = current_user.twitter.list_timeline(list.list_id, count: 200).max_by(50, &:favorite_count)
      @list_name = list.list_name
    else
      redirect_to twitter_lists_path, danger: 'リストを更新してください'
    end
  end

  def update_index
    # TODO: 今後、できればjsで作成したい
    current_user.update_twitter_lists
    redirect_to twitter_lists_path
  end
end
