class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # NOTE: #authenticate_current_user is a workaround for devise current_user
  # returning false Every client-side request must attach current_user_id
  # and session_token

  def authenticate_current_user
    render json: {}, status: :unauthorized if get_current_user.nil?
  end

  def get_current_user
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse cookies[:auth_headers]

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_user = User.find_by uid: auth_headers["uid"]

    if current_user &&
       current_user.tokens.has_key?(auth_headers["client"]) &&
       expiration_datetime > DateTime.now

      @current_user = current_user
    end
    @current_user
  end

  def configure_permitted_parameters
    # TODO: not sure why only this works! devise_token_auth is full of bugs!!!
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :company_id
    # NOTE: might be useful later.
    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
