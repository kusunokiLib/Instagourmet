class PostsController < ApplicationController
  def new
    @post = Post.new()
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to user_path(params[:user_id])
  end

  private
    def post_params
      params.require(:post).permit(:text, :user_id)
    end

end
