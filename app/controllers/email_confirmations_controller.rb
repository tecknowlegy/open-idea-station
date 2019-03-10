class EmailConfirmationsController < ApplicationController
  skip_before_action :authorize, only: %i[new create edit update]

  def new; end

  def create
    user = User.find_by_new_email(email_confirmation_params[:email])
    respond_to do |format|
      unless user.present?
        flash[:notice] = "Email does not exist or has already been confirmed"
        format.html { redirect_to new_session_path }
        return
      end

      user.send_email_confirmation
      flash[:notice] = "We have resent a confirmation email to your inbox"
    end
  end

  def edit; end

  def update
    user = User.find_by_email_confirmation_token(params[:token])
    if user
      user.confirm_email
      flash[:success] = "You have successfully confirmed your email"
    else
      flash[:success] = "Link is invalid. It may have expired or have already been used"
    end
    redirect_to new_session_path
  end

  private

  def email_confirmation_params
    params.require(:email_confirmation).permit(:email)
  end
end
