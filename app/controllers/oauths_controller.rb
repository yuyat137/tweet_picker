class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)
    if @user
      @user.update(profile_image_url: @user.twitter.user.profile_image_url.to_s)
      redirect_to twitter_lists_path, success: 'ログインしました'
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        # TODO: ここのコードがもっと綺麗にならないか調査
        Authentication.find_by(uid: @access_token.params[:user_id]).update!(access_token: @access_token.token, access_token_secret: @access_token.secret)
        @user.update(profile_image_url: @user.twitter.user.profile_image_url.to_s)

        reset_session
        auto_login(@user)
        redirect_to twitter_lists_path, success: 'ログインしました'
      rescue StandardError
        redirect_to root_path, danger: 'ログインに失敗しました'
      end
    end
  end
end
