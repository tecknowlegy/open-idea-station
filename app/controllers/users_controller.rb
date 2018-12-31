class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[new create]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    user = User.new(user_params)
    user_session = session_params.merge(
      { username: user_params[:username], password: user_params[:password] }
    )
    respond_to do |format|
      if user.save
        # TODO: Translations << Add to translations
        flash[:notice] = "Your account was successfully created"
        auth_hash = Acorn::AuthenticateUserService.call(user_session)

        if auth_hash.success?
          cookies[:user_id] = session["token"] = auth_hash.result
          format.html do
            redirect_to "/ideas"
          end
        else
          flash[:notice] = "We could not create your session at this time. Please login to continue"
          format.html do
            redirect_to "/"
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
