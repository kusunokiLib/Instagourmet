class Api::UsersController < ApplicationController

  def index
    @users = User.all
    render :json => @users
  end

  def show
    @user = User.find(params[:id])
    render :json => @user
  end

  def following
    @users = User.find(params[:user_id]).following
    render :json => @users
  end

  def followers
    @users = User.find(params[:user_id]).followers
    render :json => @users
  end

  def favorite_posts
    @posts = User.find(params[:user_id]).favorite_posts
    render :json => @posts
  end

end
