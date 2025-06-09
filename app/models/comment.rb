class Comment < ApplicationRecord
    belongs_to :user #ユーザーとの関連付け
    belongs_to :output #アウトプットとの関連付け
    has_many :notifications, dependent: :destroy

    validates :comment,presence: true, length: {maximum: 40}
end
