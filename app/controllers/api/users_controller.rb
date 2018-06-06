class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!, except: [:create, :follow, :unfollow]

  #GET
  def index
    @users = User.all
    render :json => @users, except:[:auth_token]
  end

  def show
    @user = User.find(params[:id])
    render :json => @user, except:[:auth_token]
  end

  def following
    @users = User.find(params[:user_id]).following
    render :json => @users, except:[:auth_token]
  end

  def followers
    @users = User.find(params[:user_id]).followers
    render :json => @users, except:[:auth_token]
  end

  def favorite_posts
    @posts = User.find(params[:user_id]).favorite_posts
    render :json => @posts
  end

  # POST
  # Create an user
  def create
    @user = User.new user_params

    if @user.save!
      render json: @user, root: nil
    else
      render json: { error: t('user_create_error') }, status: :unprocessable_entity
    end
  end

  def follow
    @user = User.find_by(auth_token: request.headers['Authorization'])
    @followed = User.find_by(id: params[:user_id])
    @user.follow(@followed)
    render json: { isfollowing: true }, root: nil
  end

  def unfollow
    @user = User.find_by(auth_token: request.headers['Authorization'])
    @followed = User.find_by(id: params[:user_id])
    @user.unfollow(@followed)
    render json: { isfollowing: false }, root: nil
  end

  def following?
    @user = User.find_by(auth_token: request.headers['Authorization'])
    if !@user
      render json: { status: 'false' }, status: 400
    end
    render json: { isfollowing: @user.following?(User.find_by(id: params[:user_id])) }, root: nil
  end

  def favorite
    @user = User.find_by(auth_token: request.headers['Authorization'])
    @post = Post.find_by(id: params[:post_id])
    @user.favorite(@post)
    render json: { status: 'true' }
  end

  def unfavorite
    @user = User.find_by(auth_token: request.headers['Authorization'])
    @post = Post.find_by(id: params[:post_id])
    @user.unfavorite(@post)
    render json: { status: 'true' }
  end

  def favorite?
    @user = User.find_by(auth_token: request.headers['Authorization'])
    if @user == nil
      render json: { status: 'false' }, status: 400
    else
      render json: { isFavorite: @user.favorite?(Post.find_by(id: params[:post_id])) }, root: nil
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :email, :text, :image)
    end

end
