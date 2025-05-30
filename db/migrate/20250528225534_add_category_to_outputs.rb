class AddCategoryToOutputs < ActiveRecord::Migration[7.1]
  def up
    # 1. カテゴリーカラムを追加（NULLを許可）
    add_reference :outputs, :category, null: true, foreign_key: true

    # 2. デフォルトカテゴリーを作成
    default_category = Category.create!(name: '未分類')

    # 3. 既存のレコードをデフォルトカテゴリーに更新
    Output.update_all(category_id: default_category.id)

    # 4. NOT NULL制約を追加
    change_column_null :outputs, :category_id, false
  end

  def down
    remove_reference :outputs, :category
  end
end
