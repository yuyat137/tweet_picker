class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: :new

  def new; end

  def destroy
    logout
    redirect_to login_path, success: 'ログアウトしました'
  end
end
