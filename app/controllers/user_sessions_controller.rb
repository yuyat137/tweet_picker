class UserSessionsController < ApplicationController
  def new; end

  def destroy
    logout
    redirect_to root_path
  end
end
