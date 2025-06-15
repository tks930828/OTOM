class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @outputs = @user.outputs.page(params[:page]).per(10)
    @following_users = @user.following
    @follower_users = @user.followers
  end

  def follows
    user = User.find(params[:id])
    @users = user.following.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page]).per(3).reverse_order
  end
  
end
