# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

categories = [
  { name: "文芸", description: "小説などの書籍のカテゴリーです" },
  { name: "医学", description: "医学に関する書籍のカテゴリーです" },
  { name: "工学", description: "工学に関する書籍のカテゴリーです" },
  { name: "法律", description: "法律関連の書籍のカテゴリーです" },
  { name: "ビジネス", description: "ビジネス書のカテゴリーです" },
  { name: "語学", description: "語学学習に関するカテゴリーです" },
  { name: "資格", description: "資格試験対策の書籍カテゴリーです" },
]

categories.each do |category_attrs|
  category = Category.find_or_initialize_by(name: category_attrs[:name])
  category.description = category_attrs[:description]
  category.save!
end