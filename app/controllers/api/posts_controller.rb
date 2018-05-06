class Api::PostsController < ApplicationController

  def index
    @posts = User.find(params[:user_id]).posts
    render :json => @posts
  end

  def show

  end

end
