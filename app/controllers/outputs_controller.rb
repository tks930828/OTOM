class OutputsController < ApplicationController
  def index # アウトプット一覧を表示
    @outputs = Output.all
  end

  def show # アウトプット詳細を表示
    @output = Output.find(params[:id])
  end

  def new # アウトプットを作成
    @output = Output.new
  end

  def create # アウトプットを作成
    @output = Output.new(output_params)
    if @output.save
      redirect_to @output, notice: 'アウトプットが正常に作成されました。'
    else
      render :new
    end
  end

  def edit # アウトプットを編集
    @output = Output.find(params[:id])
  end

  def update # アウトプットを更新
    @output = Output.find(params[:id])
    if @output.update(output_params)
      redirect_to @output, notice: 'アウトプットが正常に更新されました。'
    else
      render :edit
    end
  end

  def destroy # アウトプットを削除
    @output = Output.find(params[:id])
    @output.destroy
    redirect_to outputs_path, notice: 'アウトプットが正常に削除されました。'
  end

  private

  def output_params # アウトプットのパラメータを許可
    params.require(:output).permit(:book_name, :output)
  end
end
