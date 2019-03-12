class EmailConfirmationsController < ApplicationController
  skip_before_action :authorize, only: %i[new create edit update]
  before_action :redirect_logged_in_user

  def new; end

  def create
    respond_to do |format|
      if email_confirmation_params[:email].present? && email_confirmation_params[:email].match(User::EMAIL_REGEX)
        user = User.find_by_new_email(email_confirmation_params[:email])
        if user.present?
          user.send_email_confirmation
          flash[:notice] = "We have resent a confirmation email to your inbox"
        else
          flash[:notice] = "Email does not exist or has already been confirmed"
        end

        format.html { redirect_to new_session_path }
      else
        flash[:error] = "Please enter a valid email address"

        format.html { redirect_to new_email_confirmation_path }
      end
    end
  end

  def edit; end

  def update
    user = User.find_by_email_confirmation_token(params[:token].to_s)
    if user
      user.confirm_email
      flash[:success] = "Email successfully confirmed. Please sign in to continue"
      redirect_to new_session_path
    else
      flash[:success] = "Link is invalid. It may have expired or have already been used"
      redirect_to new_email_confirmation_path
    end
  end

  private

  def email_confirmation_params
    params.require(:email_confirmation).permit(:email)
  end

  # Ensure logged in users do not interract with email_confirmations actions
  def redirect_logged_in_user
    redirect_to ideas_path if logged_in?
  end
end
