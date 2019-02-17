class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[new create create_omniauth_session omniauth_user]

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    user = User.new(user_params)
    auth_params = { username: user_params[:username], password: user_params[:password] }

    if user.save
      # TODO: Translations << Add to translations
      flash[:notice] = "Your account was successfully created"
      create_session(auth_params)
    else
      flash[:error] = user.errors.full_messages[0]
      render :new
    end
  end

  def create_omniauth_session
    auth_params = { username: user_params[:username], password: user_params[:password] }

    create_session(auth_params)
  end

  def omniauth_user
    @omniauth_user = Acorn::OmniauthService.new(omniauth_hash: omniauth_hash).call

    respond_to do |format|
      if @omniauth_user.success?
        case @omniauth_user.result[:path]
        when "user" then format.html { render :omniauth_user }
        when "session" then format.html { render :omniauth_session }
        end
      else
        flash[:error] = @omniauth_user.errors[:omniauth_error].first
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation,
      :provider, :picture, :bio
    )
  end

  def omniauth_hash
    request.env["omniauth.auth"]
  end

  def create_session(auth_params)
    auth_token = Acorn::AuthenticateUserService.call(auth_params)

    respond_to do |format|
      if auth_token.success?
        # TODO: Translations << Add to translations
        flash[:success] = "You are now signed in"
        cookies[:user_id] = session["token"] = auth_token.result
        format.html { redirect_to "/ideas" }
      else
        # << and this
        flash[:error] = auth_token.errors[:user_authentication].first
        format.html { redirect_to new_session_path }
      end
    end
  end
end
