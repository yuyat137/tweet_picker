class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new guest]

  def new; end

  def destroy
    logout
    redirect_to login_path
  end

  def guest
    login('guest', 'password')
    redirect_to twitter_lists_path
  end
end
