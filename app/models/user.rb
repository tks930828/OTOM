class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :outputs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :name, presence: true
  
  # フォロー関連のアソシエーション
  has_many :active_relationships, class_name: "Relationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                 foreign_key: "followed_id",
                                 dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # 権限の定義
  ROLES = %w[admin moderator user].freeze

  # 権限チェックメソッド
  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def user?
    role == 'user'
  end

  # 権限レベルに基づくアクセス制御
  def can_manage?(resource)
    return true if admin?
    return true if moderator? && resource.user_id == id
    false
  end

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'no_image.jpg'
    end
  end

  # ユーザーをフォローする
  def follow(user)
    following << user
  end

  # ユーザーのフォローを外す
  def unfollow(user)
    following.delete(user)
  end

  # フォローしていればtrueを返す
  def following?(user)
    following.include?(user)
  end

  # フォロー通知
  def create_notification_follow!(current_user)
    # フォローされていないときだけ、レコードを作成
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end