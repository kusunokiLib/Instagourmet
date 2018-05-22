class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user_from_token!

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

  private

    def user_params
      params.require(:user).permit(:name, :password, :email, :text, :image)
    end

end
