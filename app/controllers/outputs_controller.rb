class OutputsController < ApplicationController
  before_action :set_output, only: [:show, :edit, :update, :destroy]

  def index # アウトプット一覧を表示
    @outputs = Output.all
  end

  def show # アウトプットの詳細を表示
    # @outputはbefore_actionのset_outputで設定
  end

  def new # アウトプットおよびカテゴリーの新規作成
    @output = Output.new
    @categories = Category.all
  end

  def create # アウトプットを作成
    @output = Output.new(output_params)
    if @output.save
      redirect_to @output, notice: 'アウトプットが正常に作成されました。'
    else
      @categories = Category.all
      render :new
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
      render :edit
    end
  end

  def destroy # アウトプットを削除
    @output.destroy
    redirect_to outputs_path, notice: 'アウトプットが正常に削除されました。'
  end

  private

  def set_output
    @output = Output.find(params[:id])
  end

  def output_params # アウトプットおよびカテゴリーのパラメータを取得
    params.require(:output).permit(:book_name, :output, :category_id)
  end
end
