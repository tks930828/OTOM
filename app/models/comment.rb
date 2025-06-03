class Comment < ApplicationRecord
    belongs_to :user #ユーザーとの関連付け
    belongs_to :output #アウトプットとの関連付け
end
