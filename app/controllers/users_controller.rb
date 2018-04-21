class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def following
    @user = User.find_by(id: params[:id])
  end

  def followers
    @user = User.find_by(id: params[:id])
  end

  def favorite_posts
    @user = User.find_by(id: params[:id])
  end

end
