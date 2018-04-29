class SessionsController < ApplicationController
  skip_before_action :authorize

  def login
    auth_token = AuthenticateUser.call(auth_params)

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

  def logout
    cookies.signed[:user_id] = nil
    session['jwt_token'] = nil
    redirect_to '/signup'
  end

  private

  def auth_params
    params.require(:authentication).permit(:username, :password)
  end
end
