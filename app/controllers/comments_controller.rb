class CommentsController < ApplicationController
    def create #コメントの作成
        output = Output.find(params[:output_id])
        @comment = current_user.comments.new(comment_params)
        @comment.output_id = output.id
        if @comment.save
            redirect_to output_path(output)
        else
            @output = output
            @comments = output.comments.includes(:user).page(params[:page]).per(10)
            render 'outputs/show', status: :unprocessable_entity
        end
    end

    def destroy #コメントの削除
        Comment.find_by(id: params[:id], output_id: params[:output_id]).destroy
        redirect_to output_path(params[:output_id])
    end

    private #コメントのパラメータを取得
    def comment_params
        params.require(:comment).permit(:comment)
    end
end
