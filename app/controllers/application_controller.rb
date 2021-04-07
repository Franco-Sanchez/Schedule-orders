class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # hace disponible el metodo current_user en las vistas
  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to login_path unless logged_in?
  end
end
