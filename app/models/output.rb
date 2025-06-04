class Output < ApplicationRecord
  belongs_to :category, required: true # カテゴリー設定を必須とする
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user) # いいねがあるかどうかを確認
    favorites.where(user_id: user.id).exists?
  end
end
