class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy] # カテゴリーを取得するためのメソッド

  def index #カテゴリー一覧の表示
    @categories = Category.all
    @seed_categories = Category::SEED_CATEGORIES
  end

  def show #カテゴリーの詳細表示
    @outputs = @category.outputs
  end

  def new #カテゴリーの新規作成
  end

  def edit #カテゴリーの編集
  end

  def create #カテゴリーの作成
  end

  def update #カテゴリーの更新
  end

  def destroy #カテゴリーの削除
  end

  private

  def set_category #カテゴリーを検索するための共通メソッド
    @category = Category.find(params[:id])
  end

  def category_params #カテゴリーのパラメータを取得
    params.require(:category).permit(:name, :description)
  end
end
