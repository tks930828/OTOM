class Category < ApplicationRecord
  has_many :outputs # カテゴリーに紐づく出力を取得
  validates :name, presence: true # カテゴリー名は必須
end
