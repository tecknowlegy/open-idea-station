class SessionsController < ApplicationController
  skip_before_action :authorize

  def login
    auth_token = AuthenticateUser.call(auth_params)
    create_session(auth_token)
  end

  def login_with_omniauth
    user = User.find_or_create_from_omniauth(omniauth_hash)
    user_credentials = { username: user.username, password: user.password }
    auth_token = AuthenticateUser.call(user_credentials)
    create_session(auth_token)
  end

  def logout
    cookies.signed[:user_id] = nil
    session['jwt_token'] = nil
    redirect_to '/signup'
  end

  private

  def auth_params
    params.require(:authentication).permit(:username, :password)
  end

  def omniauth_hash
    request.env['omniauth.auth']
  end

  def create_session auth_token
    respond_to do |format|
      if auth_token.success?
        session['jwt_token'] = auth_token.result
        format.html { redirect_to '/ideas' }
        format.json { render auth_token: auth_token.result, status: :success }
      else
        format.html { redirect_to '/' }
        format.json { render json: { error: auth_token.errors, status: :unauthorized } }
      end
    end
  end

end
