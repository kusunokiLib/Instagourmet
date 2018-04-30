class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
  end

  def show
    @is_followed = Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
  end

  def follow
    @followed = User.find(params[:followed_id])
    @user.follow(@followed)
    redirect_to user_path(@followed)
  end

  def unfollow
    @followed = User.find(params[:followed_id])
    @user.unfollow(@followed)
    redirect_to user_path(@followed)
  end

  def following
    @is_followed = Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
  end

  def followers
    @is_followed = Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
  end

  def favorite_posts

  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

end
