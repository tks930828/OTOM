class FavoritesController < ApplicationController
    def create
        output = Output.find(params[:output_id])
        favorite = current_user.favorites.new(output_id: output.id)
        favorite.save
        redirect_to output_path(output)
    end

    def destroy
        output = Output.find(params[:output_id])
        favorite = current_user.favorites.find_by(output_id: output.id)
        favorite.destroy
        redirect_to output_path(output)
    end
end
