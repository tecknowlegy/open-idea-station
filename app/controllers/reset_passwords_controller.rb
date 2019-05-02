class ResetPasswordsController < ApplicationController
  skip_before_action :authorize
  before_action :redirect_logged_in_user, only: %i[new create edit]

  def new; end

  def create
    respond_to do |format|
      if valid_email(reset_password_params[:email])
        user ||= User.find_by_email(reset_password_params[:email])

        if user.present?
          user.send_reset_password_email
          flash[:notice] = "We have sent a password reset link to your inbox"
        else
          flash[:notice] = "Email does not exist in our record"
        end

        format.html { redirect_to new_session_path }
      else
        flash[:error] = "Please enter a valid email address"
        format.html { redirect_to new_reset_password_path }
      end
    end
  end

  def edit; end

  def update
    user = if logged_in?
             current_user
           else
             User.find_reset_password_token(params[:token].to_s, :reset_password)
           end

    if user.nil?
      flash[:error] = "Link is invalid. It may have expired or have already been used"
      redirect_to new_session_path
    elsif user.change_password(reset_password_params.except(:email))
      user.send_reset_password_success_mail
      flash[:notice] = "You have successfully reset your password"
      redirect_to new_session_path
    else
      flash[:error] = user.errors.full_messages[0]
      redirect_to change_password_path
    end

    # Sign out all sessions for logged_in user
    # let user re-authenticate
    current_user&.revoke_all_sessions!
  end

  private

  def reset_password_params
    params.require(:reset_password).permit(
      :email, :password, :password_confirmation
    )
  end

  # Ensure logged in users do not interract with requesting new password via email
  def redirect_logged_in_user
    redirect_to ideas_path if logged_in?
  end
end
