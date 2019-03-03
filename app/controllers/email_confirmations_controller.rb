class EmailConfirmationsController < ApplicationController
  def create
    respond_to do |format|
      unless current_user.new_email.present?
        flash[:notice] = I18n.t("email_confirmations.already_confirmed")
        format.html { redirect_to ideas_path }
        return
      end

      current_user.send_email_confirmation
    end
  end
end
