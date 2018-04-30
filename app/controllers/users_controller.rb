class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
  end

  def show
    @is_followed = Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
  end

  def edit

  end

  def update
    params[:image] ||= @user.image
    if @user.update_attributes(user_params)
    else
    end
    render 'show'
  end

  def follow
    @followed = User.find(params[:id])
    @user.follow(@followed)
    redirect_to user_path(@followed)
  end

  def unfollow
    @followed = User.find(params[:id])
    @user.unfollow(@followed)
    redirect_to user_path(@followed)
  end

  def following
    @is_followed = Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
  end

  def followers
    @is_followed = Relationship.exists?(follower_id: current_user.id, followed_id: @user.id)
  end

  def favorite
    @user = User.find_by(id: params[:user_id])
    @user.favorite(Post.find(params[:post_id]))
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  def unfavorite
    @user = User.find_by(id: params[:user_id])
    @user.unfavorite(Post.find(params[:post_id]))
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  def favorite_posts

  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :text, :image)
    end

end
