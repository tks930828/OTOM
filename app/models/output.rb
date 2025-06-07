class Output < ApplicationRecord
  belongs_to :category, required: true # カテゴリー設定を必須とする
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  validates :book_name, presence: true, length: { maximum: 100 }
  validates :output, presence: true
  validate :image_type

  def favorited_by?(user) # いいねがあるかどうかを確認
    favorites.where(user_id: user.id).exists?
  end

  private

  def image_type
    if image.attached? && !image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:image, 'はJPEGまたはPNG形式のみアップロード可能です')
    end
  end
end
