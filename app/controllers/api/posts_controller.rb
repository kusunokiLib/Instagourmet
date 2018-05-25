class Api::PostsController < ApplicationController
  skip_before_action :authenticate_user_from_token!, only: [:index, :show]

  def index
    @posts = User.find(params[:user_id]).posts
    render :json => @posts
  end

  def show

  end

  def create
    @post = Post.new(post_params)
    if @post.save!
    render json: {}, status => 200
    else
      render json: { error: t('post_create_error') }, status: :unprocessable_entity
    end
  end

  def favorite_post
    @user = User.find_by(id: params[:user_id])
    @posts = @user.favorite_posts
    render :json => @posts
  end

  private
    def post_params
      params.require(:post).permit(:text, :user_id, :photo)
    end

end
