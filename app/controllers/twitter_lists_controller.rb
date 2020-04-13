class TwitterListsController < ApplicationController
  def index
    @lists = current_user.twitter.lists
  end
end
