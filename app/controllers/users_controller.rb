class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @incoming_friend_requests = @user.incoming_friend_requests
    @posts = @user.posts.ordered_by_most_recent
  end
end
