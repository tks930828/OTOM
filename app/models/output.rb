class Output < ApplicationRecord
  belongs_to :category, required: true # カテゴリー設定を必須
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :image
  
  validates :book_name, presence: true, length: { maximum: 100 }
  validates :output, presence: true, length: { maximum: 200 }
  validate :image_type

  def favorited_by?(user) # いいねがあるかどうかを確認
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_favorite!(current_user) # すでに「いいね」されているか検索
    # いいねされていない場合のみ、通知レコードを作成
    temp = Notification.where(["visitor_id = ? and visited_id = ? and output_id = ? and action = ? ", current_user.id, user_id, id, "favorite"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        output_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      # 自分の投稿に対するいいねは、通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # 自分以外にコメントしているユーザーを取得し、全員に通知を送る
  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(output_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id["user_id"])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # 1つの投稿に複数回通知する（コメントに対するコメント）
    notification = current_user.active_notifications.new(
      output_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment" 
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private

  def image_type #画像の形式指定
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:image, 'はJPEGまたはPNG形式のみアップロード可能です')
    end
  end
end
