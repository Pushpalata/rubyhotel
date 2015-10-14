class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  private
  
  def user_authentication!
    if params[:auth_token].present? or params[:token_authentication]== "true"
      #authenticate user for API
      authenticate_user_from_token!
    else
      #authenticate user with devise
      authenticate_user!
    end
  end

  def authenticate_user_from_token!
    user = User.where(:email => params[:email]).first if params[:email].present?
    # compare token and sign user if valid token
    if user && Devise.secure_compare(user.access_token, params[:user_token])
      sign_in user, store: false
    end
  end

end
