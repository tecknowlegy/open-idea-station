class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  helper_method :current_user, :logged_in?
  after_action :clear_xhr_flash

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def authorize
    redirect_to '/login' unless current_user
  end

  def clear_xhr_flash
    flash.discard if request.xhr?
  end
end
