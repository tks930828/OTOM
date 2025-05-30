class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy] # カテゴリーを取得するためのメソッド

  def index #カテゴリー一覧の表示
    @categories = Category.all
  end

  def show #カテゴリーの詳細表示
    @outputs = @category.outputs
  end

  def new #カテゴリーの新規作成
    @category = Category.new
  end

  def edit #カテゴリーの編集
  end

  def create #カテゴリーの作成
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'カテゴリーを作成しました'
    else
      render :new
    end
  end

  def update #カテゴリーの更新
    if @category.update(category_params)
      redirect_to categories_path, notice: 'カテゴリーを更新しました'
    else
      render :edit
    end
  end

  def destroy #カテゴリーの削除
    @category.destroy
    redirect_to categories_path, notice: 'カテゴリーを削除しました'
  end

  private

  def set_category #カテゴリーを検索するための共通メソッド
    @category = Category.find(params[:id])
  end

  def category_params #カテゴリーのパラメータを取得
    params.require(:category).permit(:name, :description)
  end
end
