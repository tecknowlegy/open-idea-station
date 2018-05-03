class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  # GET /users/signup
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user_credentials = { username: user_params[:username], password: user_params[:password] }
    respond_to do |format|
      if user.save
        flash[:notice] = 'Your account was successfully created'
        auth_token = AuthenticateUser.call(user_credentials)

        if auth_token.success?
          session['jwt_token'] = auth_token.result
          format.html do
            redirect_to '/ideas'
          end
        end

      else
        flash[:error] = user.errors.full_messages[0]
        format.html { render :new }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
