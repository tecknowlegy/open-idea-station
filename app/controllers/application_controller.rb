class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authorize
  helper_method :current_user, :logged_in?
  after_action :clear_xhr_flash

  def current_user
    headers["Authorization"] ||= session[:jwt_token] || request.headers["Authorization"]

    @current_user = if headers["Authorization"].present?
                      AcornService::AuthorizeUserService.new(headers).call.result
                    else
                      @current_user = nil
                    end
  end

  def logged_in?
    current_user != nil
  end

  def authorize
    unless current_user
      flash[:notice] = "Please login to perform this action"
      respond_to do |format|
        format.html { redirect_to "/signup" }
        format.json { render error: "Not Authorized", status: 401 }
      end
    end
  end

  def clear_xhr_flash
    flash.discard if request.xhr?
  end
end
