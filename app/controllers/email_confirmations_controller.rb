class EmailConfirmationsController < ApplicationController
  def new; end

  def create
    respond_to do |format|
      unless current_user.new_email.present?
        flash[:notice] = "Email has already been confirmed"
        format.html { redirect_to ideas_path }
        return
      end

      current_user.send_email_confirmation
    end
  end
end
