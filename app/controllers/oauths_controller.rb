class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)
    if @user
      redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        # アクセストークンの保存
        Authentication.find_by(uid: @access_token.params[:user_id]).update(access_token: @access_token.token, access_token_secret: @access_token.secret)

        reset_session
        auto_login(@user)
        redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
      rescue StandardError
        redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end
end
