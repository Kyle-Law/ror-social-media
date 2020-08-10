class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friendships.where(status: true)
  end


  def create
    @friend = current_user.friendships.build(friend_id: params[:friend_id], status: false)
    @friend.save
    if @friend.save
      redirect_to users_path, notice: 'friend request sent sucessfully!'
    else
      redirect_to users_path, alert: 'No duplicate request'
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(status: true)
    @friendship2 = Friendship.create(user_id: current_user.id, friend_id: @friendship.user_id, status: true)
    redirect_to users_path, notice: 'Friend Accepted!'
  end

  def destroy
    @friend = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    @friend ||= Friendship.find_by(user_id: params[:id], friend_id: current_user.id)
    @friend.destroy
    redirect_to users_path, alert: 'Request rejected!'
  end
end
