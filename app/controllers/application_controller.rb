class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authorize
  helper_method :current_user, :current_user_session, :logged_in?
  after_action :clear_xhr_flash

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
      flash[:notice] = "Please log in to perform this action"
      current_user_session&.revoke!

      respond_to do |format|
        format.html { redirect_to new_user_path }
        format.json { render error: "Not Authorized", status: 401 }
      end
    end
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

  # Takes a string of IP address and lookup a geo location from it.
  def humanize_location(ip_address)
    location = Acorn::Location.by_ip(ip_address)
    location ? location.name : t("general.na")
  end

  def clear_xhr_flash
    flash.discard if request.xhr?
  end
end
