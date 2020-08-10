class Friendship < ApplicationRecord
  after_destroy :destroy_reverse_relationship

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates_presence_of :user_id, :friend_id
  validates :user_id, uniqueness: {  scope: :friend_id,case_sensitive: false }

  has_many :confirmed_friends, through: :friendships, source: :friend
  has_many :inverse_friends, through: :friendships, source: :user

  def accept
    update(status: true)
    create_reverse_relationship
  end
  

  # private

  # def create_reverse_relationship
  #   friend.friendships.create(friend: user, status: true)
  # end

  def destroy_reverse_relationship
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end
end
