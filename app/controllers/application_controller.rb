class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  #before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user_from_token!

  respond_to :json

  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authenticate_error
    end
  end

  def authenticate_with_auth_token auth_token
    unless auth_token.include?(':')
      authenticate_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.auth_token, auth_token)
      # User can access
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  ##
  # Authentication Failure
  # Renders a 401 error
  def authenticate_error
    render json: { error: t('devise.failure.unauthenticated') }, status: 401
  end
  
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation　]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
