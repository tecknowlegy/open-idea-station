class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[index new create]
  attr_reader :success_message

  def index
    redirect_to new_user_path
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    user = User.new(user_params)

    if user.created?
      user.send_email_confirmation
      flash[:notice] = "We have sent you an email, please use the link to complete your registration"
    else
      flash[:error] = user.errors.full_messages[0]
    end

    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation,
      :provider, :picture, :bio
    )
  end
end
