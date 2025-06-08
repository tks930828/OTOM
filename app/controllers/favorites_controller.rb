class FavoritesController < ApplicationController
    def create # いいね機能
        output = Output.find(params[:output_id])
        favorite = current_user.favorites.new(output_id: output.id)
        favorite.save
        output.create_notification_favorite!(current_user)
        redirect_to output_path(output)
    end

    def destroy #いいね削除
        output = Output.find(params[:output_id])
        favorite = current_user.favorites.find_by(output_id: output.id)
        favorite.destroy
        redirect_to output_path(output)
    end


end
