class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy

  has_many :confirmed_friendships, -> { where(status: true) }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverse_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  def sent_friend_requests
    Friendship.where(['user_id = ? and status = ?', id, false])
  end

  def incoming_friend_requests
    Friendship.where(['friend_id = ? and status = ?', id, false])
  end

  def circle_posts
    friends_array = friendships.map { |friendship| friendship.friend if friendship.status }
    friends_array.concat(inverse_friendships.map { |friendship| friendship.user if friendship.status })
    friends_array = friends_array.compact.concat([id])
    Post.where(user: friends_array).ordered_by_most_recent
  end
end
