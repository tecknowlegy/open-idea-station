class SessionsController < ApplicationController
  skip_before_action :authorize, only: %i[new create create_with_omniauth]

  def index
    @active_sessions = current_user.all_sessions.active.to_a - [current_user_session]
    # TODO: Ensure @inactive_sessions is a paginated result
    @inactive_sessions = current_user.all_sessions.inactive
    @current_session = current_user_session
  end

  def create
    auth_token = Acorn::AuthenticateUserService.call(session_params)
    create_session(auth_token)
  end

  def revoke
    user_session = current_user.find_session_by_token(params[:token]) || current_user.find_session!(params[:id])
    user_session.revoke!
    flash[:notice] = "Session successfully revoked"
  end

  def revoke_all
    current_user.revoke_all_sessions!(except: session[:token])
    flash[:notice] = "All sessions successfully revoked"
  end

  def destroy
    current_user.find_session_by_token(session[:token]).revoke!
    cookies[:user_id] = session["token"] = nil
    respond_to do |format|
      format.html { redirect_to new_session_path, notice: "You are now signed out" }
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :password).merge(super)
  end

  def create_session(auth_token)
    respond_to do |format|
      if auth_token.success?
        # TODO: Translations << Add to translations
        flash[:success] = "You are now signed in"
        cookies[:user_id] = session["token"] = auth_token.result
        format.html { redirect_to "/ideas" }
      else
        # << and this
        flash[:error] = auth_token.errors[:authentication_error].first
        format.html { redirect_to new_session_path }
      end
    end
  end
end
