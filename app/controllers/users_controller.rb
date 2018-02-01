class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new_login, :new, :create]
  
  # GET /users/signup
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    # if user.save
    #   session[:user_id] = user.id
    #   redirect_to '/ideas'
    # else
    #   redirect_to '/signup'
    # end
    respond_to do |format|
      if user.save
        session[:user_id] = user.id
        format.html { redirect_to '/ideas', notice: 'User account was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_profile
  end

  def new_login
  end

  def create_login
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This keeps the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/ideas'
    else
      # If user's login doesn't work, send them back to the login form.
      #flash[:error] = "You must be logged in to access ideas"
      redirect_to '/login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :confirm_password)
  end
end
