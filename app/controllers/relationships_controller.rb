class RelationshipsController < ApplicationController
    def create
        current_user.follow(params[user.id])
        redirect_to request.referer
    end

    def destroy
        current_user.unfollow(params[:user_id])
        redirect_to request.referer
    end
end
