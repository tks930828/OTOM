class Category < ApplicationRecord
  SEED_CATEGORIES = [
    "文芸",
    "医学",
    "工学",
    "法律",
    "ビジネス",
    "語学",
    "資格"
  ]

  has_many :outputs # カテゴリーに紐づく出力を取得
  validates :name, presence: true # カテゴリー名は必須
end
