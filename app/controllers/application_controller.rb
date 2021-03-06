class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user, :current_user_session, :logged_in?
  before_action :authorize
  before_action :set_locale
  after_action :clear_xhr_flash

  include EmailValidatable

  private

  def current_user_session
    @current_user_session ||= Session.find_by(token: session[:token]) if session[:token]
  end

  # current_active_user in this context is a user
  # with an active session and valid token
  def current_user
    token ||= session[:token] || request.headers["Authorization"]
    @current_user ||= User.find_user_by_session(token) if token

    @current_user if Acorn::AuthorizeUserService.new(token).call.result
  end

  def logged_in?
    current_user != nil
  end

  def authorize
    unless current_user
      flash[:notice] = "Please log in to continue"
      current_user_session&.revoke!

      respond_to do |format|
        format.html { redirect_to new_session_path }
        format.json { render error: "Not Authorized", status: 401 }
      end
    end
  end

  def set_locale
    locale = params[:locale] || extract_locale_from_accept_language_header

    locale.present? && I18n.available_locales.include?(locale.to_sym) && current_user&.locale = locale

    I18n.locale = (current_user&.locale || locale).to_sym
  end

  def extract_locale_from_accept_language_header
    request.env.fetch("HTTP_ACCEPT_LANGUAGE", "").scan(/^[a-z]{2}/).first
  end

  def session_params
    {
      user_agent: request.user_agent,
      ip_address: request.remote_ip,
      location: nil,
      # for now we use browser. We have to find gem or
      # create logic that will tell us device platforms
      device_platform: :browser,
    }
  end

  def clear_xhr_flash
    flash.discard if request.xhr?
  end
end
