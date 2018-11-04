class SessionsController < ApplicationController
  skip_before_action :authorize

  def login
    auth_token = AcornService::AuthenticateUserService.call(auth_params)
    create_session(auth_token)
  end

  def login_with_omniauth
    user = User.find_or_create_from_omniauth(omniauth_hash)
    user_credentials = { username: user.username, password: user.password }
    auth_token = AcornService::AuthenticateUserService.call(user_credentials)
    create_session(auth_token)
  end

  def logout
    cookies[:user_id] = session["jwt_token"] = nil
    respond_to do |format|
      format.html { redirect_to "/signup", notice: "You are now logged out" }
    end
  end

  private

  def auth_params
    params.require(:authentication).permit(:username, :password)
  end

  def omniauth_hash
    request.env["omniauth.auth"]
  end

  def create_session(auth_token)
    respond_to do |format|
      if auth_token.success?
        # TODO: Translations << Add to translations
        flash[:success] = "You are now signed in"
        cookies[:user_id] = session["jwt_token"] = auth_token.result
        format.html { redirect_to "/ideas" }
      else
        # << and this
        flash[:error] = auth_token.errors[:user_authentication].first
        format.html { redirect_to "/signup" }
      end
    end
  end
end
