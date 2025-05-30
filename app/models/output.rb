class Output < ApplicationRecord
  belongs_to :category, required: true # カテゴリー設定を必須とする
end
