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
        auth_token = AuthenticateUser.call(user_credentials)

        if auth_token.success?
          session['jwt_token'] = auth_token.result
          format.html do
            redirect_to '/ideas',
                        notice: 'User account was successfully created.'
          end
        end

      else
        format.html { render :new }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :confirm_password)
  end
end
