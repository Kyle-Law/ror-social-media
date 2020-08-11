class Friendship < ApplicationRecord
  after_destroy :destroy_reverse_relationship

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_presence_of :user_id, :friend_id
  validates :user_id, uniqueness: {  scope: :friend_id,case_sensitive: false }

  
  def accept
    update(status: true)
    create_reverse_relationship
  end
  

  private

  def destroy_reverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end
end
