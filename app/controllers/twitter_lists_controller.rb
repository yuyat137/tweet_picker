class TwitterListsController < ApplicationController
  def index
    @twitter_lists = current_user.twitter_lists
  end

  def show
    @tweets_form = TweetsForm.new(tweets_params)
    @list = current_user.twitter_lists.find_by(access_id: params[:access_id])
    if @list
      @tweets, @load_period = @tweets_form.search(@list, current_user)
    else
      redirect_to twitter_lists_path, danger: 'リストを更新してください'
    end
  end

  def update_index
    # TODO: 今後、できればjsで作成したい
    current_user.update_twitter_lists
    redirect_to twitter_lists_path
  end

  private

  def tweets_params
    return unless params[:tweets_form]

    params.require(:tweets_form).permit(:read_tweets_num, :display_tweets_type, :display_tweets_num)
  end
end
