class OutputsController < ApplicationController
# before_actoin 処理の制限
  before_action :authenticate_user!, except: [:index, :show] #ログインしているユーザー
  before_action :set_output, only: [:show, :edit, :update, :destroy] 
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index # アウトプット一覧を表示
    @outputs = Output.includes(:user, :category).page(params[:page]).per(12)
  end

  def show # アウトプットの詳細を表示
    @comment = Comment.new
    @comments = @output.comments.includes(:user).page(params[:page]).per(10)
  end

  def new # アウトプットおよびカテゴリーの新規作成
    @output = Output.new
    @categories = Category.all
  end

  def create # アウトプットを作成
    @output = current_user.outputs.new(output_params)
    if @output.save
      redirect_to @output, notice: 'アウトプットが正常に作成されました。'
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit # カテゴリーを編集
    @categories = Category.all
  end

  def update # アウトプットを更新
    if @output.update(output_params)
      redirect_to @output, notice: 'アウトプットが正常に更新されました。'
    else
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # アウトプットを削除
    @output.destroy
    redirect_to outputs_path, notice: 'アウトプットを削除しました。'
  end

  private

  def set_output
    @output = Output.find(params[:id])
  end

  def ensure_correct_user
    unless @output.user == current_user
      redirect_to outputs_path, alert: '権限がありません。'
    end
  end

  def output_params # アウトプットおよびカテゴリーのパラメータを取得
    params.require(:output).permit(:book_name, :output, :category_id, :image)
  end
end
