class OmniauthsController < ApplicationController
  skip_before_action :authorize, only: %i[new create update]
  attr_reader :success_message

  # GET: retrieves data from external service
  # and renders the corresponding view depending on
  # the result of the omniauth service
  def new
    omniauth_user = Acorn::OmniauthService.new(omniauth_hash: omniauth_hash).call

    respond_to do |format|
      if omniauth_user.success?
        @user, path = omniauth_user.result
        case path
        when "new" then format.html { render :new }
        when "session" then format.html { render :session }
        end
      else
        flash[:error] = omniauth_user.errors[:omniauth_error]
        redirect_to :new_user_path
      end
    end
  end

  # POST create new user
  def create
    user = User.new(user_params)

    if user.created?
      @success_message = "Your account was successfully created"
      user.confirm_email
      create_session(session_params)
    else
      flash[:error] = user.errors.full_messages[0]
      redirect_to new_user_path
    end
  end

  #POST sign in user
  def update
    @success_message = "You are now signed in"
    create_session(session_params)
  end

  private

  def omniauth_hash
    request.env["omniauth.auth"]
  end

  def user_params
    params.require(:user).permit(
      :username, :email, :password, :password_confirmation,
      :provider, :picture, :bio
    )
  end

  def create_session(auth_params)
    auth_token = Acorn::AuthenticateUserService.call(auth_params)

    respond_to do |format|
      if auth_token.success?
        cookies[:user_id] = session["token"] = auth_token.result
        flash[:success] = success_message
        format.html { redirect_to ideas_path }
      else
        # TODO: Translations << Add to translations
        flash[:notice] = "We could not sign you in at this time. Please try again"
        format.html { redirect_to new_session_path }
      end
    end
  end

  def session_params
    super.merge({ username: user_params[:username], password: user_params[:password] })
  end
end
