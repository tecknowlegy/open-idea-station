class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  # GET /users/signup
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    respond_to do |format|
      if user.save
        session[:user_id] = user.id
        cookies.signed[:user_id] = user.id
        format.html do
          redirect_to '/ideas',
                      notice: 'User account was successfully created.'
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
